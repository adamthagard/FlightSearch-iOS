//
//  FlightStatsCommunicatorDelegate.h
//  FlightSearch
//
//  Created by Adam Thagard on 2015-12-07.
//  Copyright (c) 2015 adamthagard. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FlightStatsCommunicatorDelegate
- (void)didReceiveFlightStatuses:(NSArray *)flightStatuses;
- (void)fetchingFlightStatusesFailedWithError:(NSError *)error;
@end
