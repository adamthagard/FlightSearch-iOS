//
//  FlightStatus.h
//  FlightSearch
//
//  Created by Adam Thagard on 2015-12-03.
//  Copyright (c) 2015 adamthagard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightStatus : NSObject

@property (nonatomic,strong) NSString *status;

@property (nonatomic,strong) NSString *departureAirport;
@property (nonatomic,strong) NSString *arrivalAirport;

@property (nonatomic,strong) NSString *departureCity;
@property (nonatomic,strong) NSString *arrivalCity;

@property (nonatomic,strong) NSString *departureDate;
@property (nonatomic,strong) NSString *departureTime;
@property (nonatomic,strong) NSString *departureScheduledTime;

@property (nonatomic,strong) NSString *arrivalDate;
@property (nonatomic,strong) NSString *arrivalTime;
@property (nonatomic,strong) NSString *arrivalScheduledTime;

@property (nonatomic,strong) NSString *departureTerminal;
@property (nonatomic,strong) NSString *departureGate;
@property (nonatomic,strong) NSString *arrivalTerminal;
@property (nonatomic,strong) NSString *arrivalGate;

@property (nonatomic) float flightProgress;

@end
