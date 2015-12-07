//
//  ViewController.m
//  FlightSearch
//
//  Created by Adam Thagard on 2015-12-03.
//  Copyright (c) 2015 adamthagard. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


// Hide navigation bar on first page
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)searchFlights:(id)sender{
//    FlightsTableViewController *flightsVC = [[FlightsTableViewController alloc] init];
//    [self.navigationController pushViewController:flightsVC animated:YES];
    
    
//    NSMutableURLRequest *request =
//    [NSMutableURLRequest requestWithURL:[NSURL
//                                         URLWithString:@"https://api.flightstats.com/flex/flightstatus/rest/v2/json/flight/status/AA/138/dep/2015/12/4?appId=5a72befd&appKey=36550fa3c22e6d88762d8efc1923a952&utc=false"]
//                            cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
//                        timeoutInterval:10
//     ];
//    
//    [request setHTTPMethod: @"GET"];
//    
//    NSError *requestError = nil;
//    NSURLResponse *urlResponse = nil;
//    
//    
//    NSData *response1 =
//    [NSURLConnection sendSynchronousRequest:request
//                          returningResponse:&urlResponse error:&requestError];
//    
//    NSLog(@"RESPONSE: %@", response1);
//    
    
    
    
    NSString *urlAsString = [NSString stringWithFormat:@"https://api.flightstats.com/flex/flightstatus/rest/v2/json/flight/status/AA/138/dep/2015/12/4?appId=5a72befd&appKey=36550fa3c22e6d88762d8efc1923a952&utc=false"];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
//            [self.delegate fetchingGroupsFailedWithError:error];
        } else {
//            [self.delegate receivedGroupsJSON:data];
            NSLog(@"data: %@",data);
            
            NSError *localError = nil;
            NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];

        }
    }];
}

@end
