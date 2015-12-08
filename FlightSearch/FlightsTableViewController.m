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

- (id)initWithFlightStatuses:(NSArray*)newFlightStatuses {
    self = [super init];
    if (self) {
        flightStatuses = [[NSMutableArray alloc] initWithArray:newFlightStatuses];
        
        self.navigationItem.title = @"A custom title";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register Class for Cell Reuse Identifier
    [self.tableView registerClass:[FlightStatusTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    
    [self.tableView setRowHeight:204];
    
    self.tableView.layer.cornerRadius = 10.0f;
    self.tableView.layer.masksToBounds = YES;
    self.tableView.clipsToBounds = YES;
//    self.tableView.backgroundColor = [UIColor redColor];
    

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
//    flightStatuses = [[NSMutableArray alloc] init];
//
//    FlightStatus *testFlight = [[FlightStatus alloc] init];
//    
//    testFlight.status = @"On-time";
//    testFlight.departureAirport = @"LHR";
//    testFlight.arrivalAirport = @"LAX";
//
//    testFlight.departureCity = @"Departed London,";
//    testFlight.arrivalCity = @"Arrives Los Angeles,";
//    
//    testFlight.departureDate = @"Thursday, Dec. 3";
//    testFlight.arrivalDate = @"Thursday, Dec. 3";
//    
//    testFlight.departureTime = @"1:29 PM";
//    testFlight.arrivalTime = @"4:36 PM";
//    
//    testFlight.departureScheduledTime = @"1:30 PM";
//    testFlight.arrivalScheduledTime = @"5:00 PM";
//    
//    testFlight.departureTerminal = @"3";
//    testFlight.arrivalTerminal = @"4";
//    
//    testFlight.departureGate = @"35";
//    testFlight.arrivalGate = @"41";
//    
//    [flightStatuses addObject:testFlight];
//    
//    
//    FlightStatus *testFlight2 = [[FlightStatus alloc] init];
//    
//    testFlight2.status = @"On-time";
//    testFlight2.departureAirport = @"DFW";
//    testFlight2.arrivalAirport = @"DCA";
//    
//    testFlight2.departureCity = @"Departed Dallas,";
//    testFlight2.arrivalCity = @"Arrives Washington D.C.,";
//    
//    testFlight2.departureDate = @"Thursday, Dec. 3";
//    testFlight2.arrivalDate = @"Thursday, Dec. 3";
//    
//    testFlight2.departureTime = @"5:00 PM";
//    testFlight2.arrivalTime = @"8:49 PM";
//    
////    testFlight2.departureScheduledTime = @"1:30 PM";
////    testFlight2.arrivalScheduledTime = @"5:00 PM";
//    
//    testFlight2.departureTerminal = @"A";
//    testFlight2.arrivalTerminal = @"C";
//    
//    testFlight2.departureGate = @"A11";
//    testFlight2.arrivalGate = @"25";
//    
////    [flightStatuses addObject:testFlight2];
    
//    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [flightStatuses count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FlightStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
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

    return cell;
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
