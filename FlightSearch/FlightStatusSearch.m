//
//  FlightStatusSearch.m
//  FlightSearch
//
//  Created by Adam Thagard on 2015-12-07.
//  Copyright (c) 2015 adamthagard. All rights reserved.
//

#import "FlightStatusSearch.h"

@implementation FlightStatusSearch

- (id)initWithFlightStatusSearch:(FlightStatusSearch*)otherFlightStatusSearch {
    self = [super init];
    if (self) {
        self.airlineCode = otherFlightStatusSearch.airlineCode;
        self.flightNumber = otherFlightStatusSearch.flightNumber;
        self.searchDate = otherFlightStatusSearch.searchDate;
        self.flightStatusesArray = [[NSArray alloc] initWithArray:otherFlightStatusSearch.flightStatusesArray];
        self.lastUpdated = otherFlightStatusSearch.lastUpdated;
    }
    return self;
}

@end
