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

- (id)initWithFlightSearchResults:(FlightStatusSearch*)newFlightStatusSearchResults {
    self = [super init];
    if (self) {
        flightStatusSearch = [[FlightStatusSearch alloc] initWithFlightStatusSearch:newFlightStatusSearchResults];
        
//        self.navigationItem.title = [NSString stringWithFormat:@"%@%@",flightStatusSearch.airlineCode,flightStatusSearch.flightNumber];

        NSString *titleText = [NSString stringWithFormat:@"%@%@",flightStatusSearch.airlineCode,flightStatusSearch.flightNumber];
        
//        CGRect frame = CGRectMake(0, 0, [titleText sizeWithFont:[UIFont boldSystemFontOfSize:24.0]].width, 44);
        CGRect frame = CGRectMake(0, 0, [titleText sizeWithAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:24.0]}].width, 44);
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:24.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        label.text = titleText;
        
        self.navigationItem.titleView = label;
        
        [self updateLastUpdatedLabel];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register Class for Cell Reuse Identifier
    [self.tableView registerClass:[FlightStatusTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    
    [self.tableView setRowHeight:204];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl]; //assumes tableView is @property
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // initialize communicator to interact with flight stats API and return results here
    _communicator = [[FlightStatsCommunicator alloc] init];
    _communicator.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont boldSystemFontOfSize:16.0f], NSFontAttributeName,
      nil]];
    
    
//    [self.navigationController.navigationBar setBackgroundColor:[UIColor blueColor]];
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.0 green:67.0/255.0 blue:139.0/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTintColor:[UIColor darkGrayColor]];
//    [self.navigationController.navigationBar set:[UIColor lightGrayColor]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma refresh control

-(void)refresh {
    NSLog(@"refresh results");
    
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing..."];
    
    [self.communicator searchFlights:flightStatusSearch];
}


- (void)updateLastUpdatedLabel{
    // update last updated label
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@",[formatter stringFromDate:flightStatusSearch.lastUpdated]];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
}

#pragma FlightStatsCommunicatorDelegate

- (void)didReceiveFlightStatuses:(FlightStatusSearch *)completedFlightStatusSearch{
    
    flightStatusSearch = completedFlightStatusSearch;
    
    [self.tableView reloadData];

    [self.refreshControl endRefreshing];
    
    [self updateLastUpdatedLabel];
}


- (void)fetchingFlightStatusesFailedWithError:(NSError *)error{
        
    if (error.code == -1009){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
                                                        message:@"You must be connected to the internet to use this app."
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
    return [flightStatusSearch.flightStatusesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FlightStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSArray *flightStatuses = flightStatusSearch.flightStatusesArray;
    
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
   
//    [cell.departureTerminalLabel setText:[NSString stringWithFormat:@"Terminal: %d",[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] departureTerminal]]];
//    [cell.arrivalTerminalLabel setText:[NSString stringWithFormat:@"Terminal: %d",[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] arrivalTerminal]]];
    
//    [cell.departureGateLabel setText:[NSString stringWithFormat:@"Gate: %d",[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] departureGate]]];
//    [cell.arrivalGateLabel setText:[NSString stringWithFormat:@"Gate: %d",[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] arrivalGate]]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell drawFlightVisualWithCellFrame:cell.frame progress:[(FlightStatus*)[flightStatuses objectAtIndex:indexPath.row] flightProgress]];
    
    return cell;
}



-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    NSLog(@"ROTATE!");
    
    [self.tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
