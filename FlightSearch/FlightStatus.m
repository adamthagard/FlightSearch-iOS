//
//  FlightStatus.m
//  FlightSearch
//
//  Created by Adam Thagard on 2015-12-03.
//  Copyright (c) 2015 adamthagard. All rights reserved.
//

#import "FlightStatus.h"

@implementation FlightStatus

# pragma nscoding

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.status forKey:@"status"];
    [encoder encodeObject:self.departureAirport forKey:@"departureAirport"];
    [encoder encodeObject:self.arrivalAirport forKey:@"arrivalAirport"];
    [encoder encodeObject:self.departureCity forKey:@"departureCity"];
    [encoder encodeObject:self.arrivalCity forKey:@"arrivalCity"];
    
    [encoder encodeObject:self.departureDate forKey:@"departureDate"];
    [encoder encodeObject:self.departureTime forKey:@"departureTime"];
    [encoder encodeObject:self.departureScheduledTime forKey:@"departureScheduledTime"];
    
    [encoder encodeObject:self.arrivalDate forKey:@"arrivalDate"];
    [encoder encodeObject:self.arrivalTime forKey:@"arrivalTime"];
    [encoder encodeObject:self.arrivalScheduledTime forKey:@"arrivalScheduledTime"];
    
    [encoder encodeObject:self.departureTerminal forKey:@"departureTerminal"];
    [encoder encodeObject:self.departureGate forKey:@"departureGate"];
    [encoder encodeObject:self.arrivalTerminal forKey:@"arrivalTerminal"];
    [encoder encodeObject:self.arrivalGate forKey:@"arrivalGate"];

    [encoder encodeFloat:self.flightProgress forKey:@"flightProgress"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.status = [decoder decodeObjectForKey:@"status"];
        self.departureAirport = [decoder decodeObjectForKey:@"departureAirport"];
        self.arrivalAirport = [decoder decodeObjectForKey:@"arrivalAirport"];
        self.departureCity = [decoder decodeObjectForKey:@"departureCity"];
        self.arrivalCity = [decoder decodeObjectForKey:@"arrivalCity"];
        
        self.departureDate = [decoder decodeObjectForKey:@"departureDate"];
        self.departureTime = [decoder decodeObjectForKey:@"departureTime"];
        self.departureScheduledTime = [decoder decodeObjectForKey:@"departureScheduledTime"];
        
        self.arrivalDate = [decoder decodeObjectForKey:@"arrivalDate"];
        self.arrivalTime = [decoder decodeObjectForKey:@"arrivalTime"];
        self.arrivalScheduledTime = [decoder decodeObjectForKey:@"arrivalScheduledTime"];
        
        self.departureTerminal = [decoder decodeObjectForKey:@"departureTerminal"];
        self.departureGate = [decoder decodeObjectForKey:@"departureGate"];
        self.arrivalTerminal = [decoder decodeObjectForKey:@"arrivalTerminal"];
        self.arrivalGate = [decoder decodeObjectForKey:@"arrivalGate"];

        self.flightProgress = [decoder decodeFloatForKey:@"flightProgress"];
    }
    return self;
}



@end
