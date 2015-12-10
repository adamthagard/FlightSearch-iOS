//
//  FlightStatsCommunicatorTests.m
//  FlightSearch
//
//  Created by Adam Thagard on 2015-12-10.
//  Copyright (c) 2015 adamthagard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "FlightStatsCommunicator.h"

@interface FlightStatsCommunicatorTests : XCTestCase

@property (nonatomic) FlightStatsCommunicator *fsCommunicatorToTest;

@end

@implementation FlightStatsCommunicatorTests

- (void)setUp {
    [super setUp];

    self.fsCommunicatorToTest = [[FlightStatsCommunicator alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testJSONParsing {

    // recreate structore of FlightStats JSON
    NSDictionary *airportsJSON = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  @"Washington",@"DCA",
                                  @"Hong Kong",@"HKG",
                                  @"Dallas",@"DFW",
                                  nil];
    NSDictionary *operationalTimes =[[NSDictionary alloc]initWithObjectsAndKeys:
                                     [[NSDictionary alloc] initWithObjectsAndKeys:@"2015-12-10T05:40:00.000Z",@"dateUtc",@"2015-12-10T13:40:00.000",@"dateLocal", nil],@"scheduledGateDeparture",
                                     [[NSDictionary alloc] initWithObjectsAndKeys:@"2015-12-10T05:24:00.000Z",@"dateUtc",@"2015-12-10T13:24:00.000",@"dateLocal", nil],@"estimatedGateDeparture",
                                     [[NSDictionary alloc] initWithObjectsAndKeys:@"2015-12-10T20:00:00.000Z",@"dateUtc",@"2015-12-10T14:00:00.000",@"dateLocal", nil],@"scheduledGateArrival",
                                     [[NSDictionary alloc] initWithObjectsAndKeys:@"2015-12-10T18:48:00.000Z",@"dateUtc",@"2015-12-10T12:48:00.000",@"dateLocal", nil],@"estimatedGateArrival",
                                     nil];
    NSDictionary *airportResources =[[NSDictionary alloc]initWithObjectsAndKeys:
                                     @"1",@"departureTerminal",
                                     @"26",@"departureGate",
                                     @"D",@"arrivalTerminal",
                                     @"21",@"arrivalGate",
                                     nil];
    NSDictionary *flightStatusJSON = [[NSDictionary alloc]initWithObjectsAndKeys:
                                      @"L",@"status",
                                      @"HKG",@"departureAirportFsCode",
                                      @"DFW",@"arrivalAirportFsCode",
                                      operationalTimes, @"operationalTimes",
                                      airportResources, @"airportResources",
                                      nil];

    
    // test parsing FlightStats JSON to FlightStatus object
    FlightStatus *resultingFlightStatus = [self.fsCommunicatorToTest flightStatusFromJSON:flightStatusJSON withAirports:airportsJSON];
    
    XCTAssertEqualObjects(resultingFlightStatus.status, @"Landed",@"JSON parsing failed - status");
    XCTAssertEqualObjects(resultingFlightStatus.departureAirport, @"HKG",@"JSON parsing failed - departureAirport");
    XCTAssertEqualObjects(resultingFlightStatus.departureCity, @"Hong Kong",@"JSON parsing failed - departureCity");
    XCTAssertEqualObjects(resultingFlightStatus.arrivalAirport, @"DFW",@"JSON parsing failed - arrivalAirport");
    XCTAssertEqualObjects(resultingFlightStatus.arrivalCity, @"Dallas",@"JSON parsing failed - arrivalCity");
    XCTAssertEqualObjects(resultingFlightStatus.departureDate, @"Thursday, Dec. 10",@"JSON parsing failed - departureDate");
    XCTAssertEqualObjects(resultingFlightStatus.departureTime, @"1:24 PM",@"JSON parsing failed - departureTime");
    XCTAssertEqualObjects(resultingFlightStatus.departureScheduledTime, @"1:40 PM",@"JSON parsing failed - departureScheduledTime");
    XCTAssertEqualObjects(resultingFlightStatus.arrivalDate, @"Thursday, Dec. 10",@"JSON parsing failed - arrivalDate");
    XCTAssertEqualObjects(resultingFlightStatus.arrivalTime, @"12:48 PM",@"JSON parsing failed - arrivalTime");
    XCTAssertEqualObjects(resultingFlightStatus.arrivalScheduledTime, @"2:00 PM",@"JSON parsing failed - arrivalScheduledTime");
    XCTAssertEqualObjects(resultingFlightStatus.departureTerminal, @"1",@"JSON parsing failed - departureTerminal");
    XCTAssertEqualObjects(resultingFlightStatus.departureGate, @"26",@"JSON parsing failed - departureGate");
    XCTAssertEqualObjects(resultingFlightStatus.arrivalTerminal, @"D",@"JSON parsing failed - arrivalTerminal");
    XCTAssertEqualObjects(resultingFlightStatus.arrivalGate, @"21",@"JSON parsing failed - arrivalGate");
}



@end
