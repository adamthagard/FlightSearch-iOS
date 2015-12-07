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

@interface FlightsTableViewController : UITableViewController{
    NSMutableArray *flightStatuses;
}

@end
