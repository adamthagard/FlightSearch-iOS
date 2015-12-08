//
//  FlightsTableViewController.h
//  FlightSearch
//
//  Created by Adam Thagard on 2015-12-03.
//  Copyright (c) 2015 adamthagard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlightStatus.h"
#import "FlightStatusTableViewCell.h"
#import "FlightStatusSearch.h"
#import "FlightStatsCommunicator.h"
#import "FlightStatsCommunicatorDelegate.h"

@interface FlightsTableViewController : UITableViewController<FlightStatsCommunicatorDelegate>{
    FlightStatusSearch *flightStatusSearch;
}

@property (strong, nonatomic) FlightStatsCommunicator *communicator;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

- (id)initWithFlightSearchResults:(FlightStatusSearch*)newFlightStatusSearchResults andRefresh:(BOOL)shouldRefresh;

@end
