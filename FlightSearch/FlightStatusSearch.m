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


// check if two flight searches have the same parameters
- (BOOL)isSameSearchAs:(FlightStatusSearch*)otherFlightStatusSearch{
    if ([self.airlineCode isEqualToString:otherFlightStatusSearch.airlineCode]
        && [self.flightNumber isEqualToString:otherFlightStatusSearch.flightNumber]
        && [self.searchDate isEqualToDate:otherFlightStatusSearch.searchDate])
        return YES;
    else
        return NO;
}


# pragma nscoding (so it can be saved in nsuserdefaults)

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.airlineCode forKey:@"airlineCode"];
    [encoder encodeObject:self.flightNumber forKey:@"flightNumber"];
    [encoder encodeObject:self.searchDate forKey:@"searchDate"];
    [encoder encodeObject:self.flightStatusesArray forKey:@"flightStatusesArray"];
    [encoder encodeObject:self.lastUpdated forKey:@"lastUpdated"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.airlineCode = [decoder decodeObjectForKey:@"airlineCode"];
        self.flightNumber = [decoder decodeObjectForKey:@"flightNumber"];
        self.searchDate = [decoder decodeObjectForKey:@"searchDate"];
        self.flightStatusesArray = [decoder decodeObjectForKey:@"flightStatusesArray"];
        self.lastUpdated = [decoder decodeObjectForKey:@"lastUpdated"];
    }
    return self;
}

@end
