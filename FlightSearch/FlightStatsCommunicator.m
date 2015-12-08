//
//  FlightStatsCommunicator.m
//  FlightSearch
//
//  Created by Adam Thagard on 2015-12-06.
//  Copyright (c) 2015 adamthagard. All rights reserved.
//

#import "FlightStatsCommunicator.h"

@implementation FlightStatsCommunicator

- (id)init {
    self = [super init];
    if (self) {
        flightStatsDF = [[NSDateFormatter alloc] init];
        [flightStatsDF setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
        
        dayDF = [[NSDateFormatter alloc] init];
        [dayDF setDateFormat:@"EEEE, MMM. d"];
        
        timeDF = [[NSDateFormatter alloc] init];
        [timeDF setDateFormat:@"h:mm a"];
        
        urlDF = [[NSDateFormatter alloc] init];
        [urlDF setDateFormat:@"yyyy'/'MM'/'dd"];
        
        flightStatusDescriptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"En-Route", @"A",
                                    @"Canceled", @"C",
                                    @"Diverted", @"D",
                                    @"Data Source Needed", @"DN",
                                    @"Landed", @"L",
                                    @"Not Operational", @"NO",
                                    @"Redirected", @"R",
                                    @"Scheduled", @"S",
                                    @"Unknown", @"U",
                                          nil];
    }
    return self;
}



- (void)searchFlightsWithAirline:(NSString*)airlineCode flightNumber:(NSString*)flightNumber date:(NSDate*)date{
    
    NSString *urlFormattedDate = [urlDF stringFromDate:date];
    
    NSString *urlAsString = [NSString stringWithFormat:@"https://api.flightstats.com/flex/flightstatus/rest/v2/json/flight/status/%@/%@/dep/%@?appId=5a72befd&appKey=36550fa3c22e6d88762d8efc1923a952&utc=false",airlineCode,flightNumber,urlFormattedDate];
//    NSString *urlAsString = [NSString stringWithFormat:@"https://api.flightstats.com/flex/flightstatus/rest/v2/json/flight/status/AA/138/dep/2015/12/4?appId=5a72befd&appKey=36550fa3c22e6d88762d8efc1923a952&utc=false"];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self requestFailedWithError:error];
        } else {
            [self receiveFlightStatsJSON:data];
        }
    }];
}


- (void)receiveFlightStatsJSON:(NSData *)data{
    NSLog(@"data: %@",data);
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];

    
    // grab the airport names from the appendix of the recieved JSON
    
    NSMutableDictionary *airportCitiesDict = [[NSMutableDictionary alloc] init];
    NSArray *airportsArrayJSON = [[parsedObject objectForKey:@"appendix"] objectForKey:@"airports"];
    
    for (NSDictionary *currAirportInfoJSON in airportsArrayJSON){
        NSString *currAirportFsCode = [currAirportInfoJSON objectForKey:@"fs"];
        NSString *currAirportCity = [currAirportInfoJSON objectForKey:@"city"];
     
        [airportCitiesDict setObject:currAirportCity forKey:currAirportFsCode];
    }
    
    
    // parse the info of each flight status
    
    NSArray *flightStatusesJSON = [[NSArray alloc] initWithArray:[parsedObject objectForKey:@"flightStatuses"]];
    
    NSMutableArray *flightStatusesArray = [[NSMutableArray alloc] init];

    for (NSDictionary *currFlightStatusJSON in flightStatusesJSON){
        
        FlightStatus *flightStatus = [[FlightStatus alloc] init];
        
        flightStatus.status = [flightStatusDescriptions objectForKey:[currFlightStatusJSON objectForKey:@"status"]];

        flightStatus.departureAirport = [currFlightStatusJSON objectForKey:@"departureAirportFsCode"];
        flightStatus.arrivalAirport = [currFlightStatusJSON objectForKey:@"arrivalAirportFsCode"];

        flightStatus.departureCity = [airportCitiesDict objectForKey:flightStatus.departureAirport];
        flightStatus.arrivalCity = [airportCitiesDict objectForKey:flightStatus.arrivalAirport];

        NSDictionary *operationalTimes = [currFlightStatusJSON objectForKey:@"operationalTimes"];
        
        
        NSDate *departureScheduledDate = [flightStatsDF dateFromString:[[operationalTimes objectForKey:@"scheduledGateDeparture"] objectForKey:@"dateLocal"]];
        flightStatus.departureScheduledTime = [timeDF stringFromDate:departureScheduledDate];
        
        NSDate *departureDate = departureScheduledDate;
        if ([operationalTimes objectForKey:@"estimatedGateDeparture"])
            departureDate = [flightStatsDF dateFromString:[[operationalTimes objectForKey:@"estimatedGateDeparture"] objectForKey:@"dateLocal"]];
        flightStatus.departureDate = [dayDF stringFromDate:departureDate];
        flightStatus.departureTime = [timeDF stringFromDate:departureDate];
        

        NSDate *arrivalScheduledDate = [flightStatsDF dateFromString:[[operationalTimes objectForKey:@"scheduledGateArrival"] objectForKey:@"dateLocal"]];
        flightStatus.arrivalScheduledTime = [timeDF stringFromDate:arrivalScheduledDate];
        
        NSDate *arrivalDate = arrivalScheduledDate;
        if ([operationalTimes objectForKey:@"estimatedGateArrival"])
            arrivalDate = [flightStatsDF dateFromString:[[operationalTimes objectForKey:@"estimatedGateArrival"] objectForKey:@"dateLocal"]];
        flightStatus.arrivalDate = [dayDF stringFromDate:arrivalDate];
        flightStatus.arrivalTime = [timeDF stringFromDate:arrivalDate];
        

        NSDictionary *airportResources = [currFlightStatusJSON objectForKey:@"airportResources"];
        
        flightStatus.departureTerminal = ([airportResources objectForKey:@"departureTerminal"]) ? [airportResources objectForKey:@"departureTerminal"] : @"N/A";
        flightStatus.departureGate = ([airportResources objectForKey:@"departureGate"]) ? [airportResources objectForKey:@"departureGate"] : @"N/A";
        flightStatus.arrivalTerminal = ([airportResources objectForKey:@"arrivalTerminal"]) ? [airportResources objectForKey:@"arrivalTerminal"] : @"N/A";
        flightStatus.arrivalGate = ([airportResources objectForKey:@"arrivalGate"]) ? [airportResources objectForKey:@"arrivalGate"] : @"N/A";


        // add the new flight status to the array of statuses
        [flightStatusesArray addObject:flightStatus];
    }
    
    NSLog(@"Done");
    
    // return the results back to the view controller (make sure it's on the main thread since UI will be updated)
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate didReceiveFlightStatuses:flightStatusesArray];
    });
}



- (void)requestFailedWithError:(NSError *)error{
//    NSLog(@"Error %@; %@", error, [error localizedDescription]);
    
    [self.delegate fetchingFlightStatusesFailedWithError:error];
}







@end
