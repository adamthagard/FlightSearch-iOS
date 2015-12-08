//
//  FlightStatsCommunicator.h
//  FlightSearch
//
//  Created by Adam Thagard on 2015-12-06.
//  Copyright (c) 2015 adamthagard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlightStatus.h"
#import "FlightStatsCommunicatorDelegate.h"

@interface FlightStatsCommunicator : NSObject{
    NSDateFormatter *flightStatsDF;
    NSDateFormatter *dayDF;
    NSDateFormatter *timeDF;
}

@property (weak, nonatomic) id<FlightStatsCommunicatorDelegate> delegate;

- (void)searchFlightsWithAirline:(NSString*)airlineCode flightNumber:(NSString*)flightNumber date:(NSString*)date;

@end
