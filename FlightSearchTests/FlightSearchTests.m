//
//  FlightSearchTests.m
//  FlightSearch
//
//  Created by Adam Thagard on 2015-12-10.
//  Copyright (c) 2015 adamthagard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "ViewController.h"
#import "FlightsTableViewController.h"

@interface FlightSearchTests : XCTestCase

@property (nonatomic) ViewController *vcToTest;
@property (nonatomic) FlightsTableViewController *flightsTVCToTest;

@end

@implementation FlightSearchTests

- (void)setUp {
    [super setUp];

    self.vcToTest = [[ViewController alloc] init];
    self.flightsTVCToTest = [[FlightsTableViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


// test that the custom FlightStatusSearch object is saved and loaded from NSUserDefaults
- (void)testOfflineSave {
    
    FlightStatusSearch *testSearch = [[FlightStatusSearch alloc] init];
    testSearch.airlineCode = @"AA";
    testSearch.flightNumber = @"138";

    [self.flightsTVCToTest setFlightStatusSearch:testSearch];
    
    [self.flightsTVCToTest saveFlightSearch];
    
    FlightStatusSearch *loadedSearch = [self.vcToTest loadLatestSearch];
    
    NSLog(@"LOADED SEARCH: %@-%@",loadedSearch.airlineCode,loadedSearch.flightNumber);
    
    XCTAssertEqualObjects(testSearch.airlineCode, loadedSearch.airlineCode,@"Offline Save Failed");
}


@end
