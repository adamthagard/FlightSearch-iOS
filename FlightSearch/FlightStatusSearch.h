//
//  FlightStatusSearch.h
//  FlightSearch
//
//  Created by Adam Thagard on 2015-12-07.
//  Copyright (c) 2015 adamthagard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightStatusSearch : NSObject

@property (nonatomic,strong) NSString *airlineCode;
@property (nonatomic,strong) NSString *flightNumber;
@property (nonatomic,strong) NSDate *searchDate;

@property (nonatomic,strong) NSArray *flightStatusesArray;

@property (nonatomic,strong) NSDate *lastUpdated;

@end
