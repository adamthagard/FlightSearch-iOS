//
//  FlightsTableViewController.m
//  FlightSearch
//
//  Created by Adam Thagard on 2015-12-03.
//  Copyright (c) 2015 adamthagard. All rights reserved.
//

#import "FlightsTableViewController.h"

static NSString *CellIdentifier = @"CellIdentifier";

@interface FlightsTableViewController ()

@end

@implementation FlightsTableViewController

- (id)initWithFlightSearchResults:(FlightStatusSearch*)newFlightStatusSearchResults andRefresh:(BOOL)shouldRefresh {
    self = [super init];
    if (self) {
        
        self.flightStatusSearch = [[FlightStatusSearch alloc] initWithFlightStatusSearch:newFlightStatusSearchResults];
        
        [self saveFlightSearch];
        
        if (shouldRefresh){
            [self.refreshControl beginRefreshing];

            [self refresh];
        }
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register Class for Cell Reuse Identifier
    [self.tableView registerClass:[FlightStatusTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    // configure tableview
    [self.tableView setRowHeight:204];
    
    // set up pull to refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl]; //assumes tableView is @property
    
    // initialize communicator to interact with flight stats API and return results here
    _communicator = [[FlightStatsCommunicator alloc] init];
    _communicator.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // set up navbar title
    NSString *titleText = [NSString stringWithFormat:@"%@%@",self.flightStatusSearch.airlineCode,self.flightStatusSearch.flightNumber];
    CGRect frame = CGRectMake(0, 0, [titleText sizeWithAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:24.0]}].width, 44);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:24.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.text = titleText;
    self.navigationItem.titleView = label;
    
    [self.navigationController.navigationBar setTintColor:[UIColor darkGrayColor]];
    
    [self updateLastUpdatedLabel];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) saveFlightSearch{
    NSLog(@"saving search: %@ with flight: %@%@",self.flightStatusSearch,self.flightStatusSearch.airlineCode,self.flightStatusSearch.flightNumber);

    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.flightStatusSearch];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:@"LastFlightSearch"];
    [defaults synchronize];
}

#pragma refresh control

-(void)refresh {
    NSLog(@"refresh results");
    
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing..."];
    
    [self.communicator searchFlights:self.flightStatusSearch];
}


- (void)updateLastUpdatedLabel{
    // update last updated label
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@",[formatter stringFromDate:self.flightStatusSearch.lastUpdated]];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
}

#pragma FlightStatsCommunicatorDelegate

- (void)didReceiveFlightStatuses:(FlightStatusSearch *)completedFlightStatusSearch{
    
    self.flightStatusSearch = completedFlightStatusSearch;
    [self saveFlightSearch];

    [self.tableView reloadData];

    [self.refreshControl endRefreshing];
    
    [self updateLastUpdatedLabel];
}


- (void)fetchingFlightStatusesFailedWithError:(NSError *)error{
        
    if (error.code == -1009){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
                                                        message:@"You must be connected to refresh results."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"An unkown error occurred"
                                                        message:@""
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    [self.refreshControl endRefreshing];
    [self updateLastUpdatedLabel];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.flightStatusSearch.flightStatusesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FlightStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSArray *flightStatuses = self.flightStatusSearch.flightStatusesArray;
    
    [cell.statusLabel setText:[NSString stringWithFormat:@"%@",[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] status]]];
    
    [cell.departureAirportLabel setText:[NSString stringWithFormat:@"%@",[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] departureAirport]]];
    [cell.arrivalAirportLabel setText:[NSString stringWithFormat:@"%@",[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] arrivalAirport]]];
    
    [cell.departureCityLabel setText:[NSString stringWithFormat:@"%@",[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] departureCity]]];
    [cell.arrivalCityLabel setText:[NSString stringWithFormat:@"%@",[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] arrivalCity]]];
    
    [cell.departureDateLabel setText:[NSString stringWithFormat:@"%@",[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] departureDate]]];
    [cell.arrivalDateLabel setText:[NSString stringWithFormat:@"%@",[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] arrivalDate]]];
    
    [cell.departureTimeLabel setText:[NSString stringWithFormat:@"%@",[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] departureTime]]];
    [cell.arrivalTimeLabel setText:[NSString stringWithFormat:@"%@",[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] arrivalTime]]];
    
    [cell.departureScheduledTimeLabel setText:[NSString stringWithFormat:@"Scheduled: %@",[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] departureScheduledTime]]];
    [cell.arrivalScheduledTimeLabel setText:[NSString stringWithFormat:@"Scheduled: %@",[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] arrivalScheduledTime]]];
    
    [cell.departureTerminalLabel setText:[NSString stringWithFormat:@"Terminal %@, Gate %@",[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] departureTerminal],[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] departureGate]]];
    [cell.arrivalTerminalLabel setText:[NSString stringWithFormat:@"Terminal %@, Gate %@",[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] arrivalTerminal],[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] arrivalGate]]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell drawFlightVisualWithCellFrame:cell.frame progress:[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] flightProgress]];
    
    [cell updatePunctualityColor:[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] punctuality]];
    
    return cell;
}



-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    NSLog(@"ROTATE!");
    
    [self.tableView reloadData];
}


@end
