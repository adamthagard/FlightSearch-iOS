//
//  ViewController.h
//  FlightSearch
//
//  Created by Adam Thagard on 2015-12-03.
//  Copyright (c) 2015 adamthagard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlightsTableViewController.h"
#import "FlightStatsCommunicator.h"
#import "FlightStatsCommunicatorDelegate.h"
#import "FlightStatusSearch.h"

@interface ViewController : UIViewController<FlightStatsCommunicatorDelegate>{
    IBOutlet UITextField *airlineCodeTextField;
    IBOutlet UITextField *flightNumberTextField;
    IBOutlet UITextField *dateTextField;
   
    NSDate *selectedDate;
}

@property (strong, nonatomic) FlightStatsCommunicator *communicator;


@end

