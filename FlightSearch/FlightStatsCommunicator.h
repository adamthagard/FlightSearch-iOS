//
//  FlightStatsCommunicator.h
//  FlightSearch
//
//  Created by Adam Thagard on 2015-12-06.
//  Copyright (c) 2015 adamthagard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlightStatus.h"
#import "FlightStatusSearch.h"
#import "FlightStatsCommunicatorDelegate.h"

@interface FlightStatsCommunicator : NSObject{
    NSDateFormatter *flightStatsDF;
    NSDateFormatter *flightStatsUTCDF;
    NSDateFormatter *dayDF;
    NSDateFormatter *timeDF;
    NSDateFormatter *urlDF;
    
    NSDictionary *flightStatusDescriptions;
}

@property (weak, nonatomic) id<FlightStatsCommunicatorDelegate> delegate;

//- (void)searchFlightsWithAirline:(NSString*)airlineCode flightNumber:(NSString*)flightNumber date:(NSDate*)date;
- (void)searchFlights:(FlightStatusSearch*)flightStatusSearch;

@end
