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

        flightStatsUTCDF = [[NSDateFormatter alloc] init];
        flightStatsUTCDF.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        [flightStatsUTCDF setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
        
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



- (void)searchFlights:(FlightStatusSearch*)flightStatusSearch{
//    - (void)searchFlightsWithAirline:(NSString*)airlineCode flightNumber:(NSString*)flightNumber date:(NSDate*)date{
    
    NSString *urlFormattedDate = [urlDF stringFromDate:flightStatusSearch.searchDate];
    
    NSString *urlAsString = [NSString stringWithFormat:@"https://api.flightstats.com/flex/flightstatus/rest/v2/json/flight/status/%@/%@/dep/%@?appId=5a72befd&appKey=36550fa3c22e6d88762d8efc1923a952&utc=false",flightStatusSearch.airlineCode,flightStatusSearch.flightNumber,urlFormattedDate];
//    NSString *urlAsString = [NSString stringWithFormat:@"https://api.flightstats.com/flex/flightstatus/rest/v2/json/flight/status/AA/138/dep/2015/12/4?appId=5a72befd&appKey=36550fa3c22e6d88762d8efc1923a952&utc=false"];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self requestFailedWithError:error];
        } else {
            [self receiveFlightStatsJSON:data forFlightStatusSearch:flightStatusSearch];
        }
    }];
}


- (void)receiveFlightStatsJSON:(NSData *)data forFlightStatusSearch:(FlightStatusSearch*)flightStatusSearch{
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
        
        NSDictionary *operationalTimes = [currFlightStatusJSON objectForKey:@"operationalTimes"];
        NSDictionary *airportResources = [currFlightStatusJSON objectForKey:@"airportResources"];

        FlightStatus *flightStatus = [[FlightStatus alloc] init];
        
        flightStatus.status = [flightStatusDescriptions objectForKey:[currFlightStatusJSON objectForKey:@"status"]];

        flightStatus.flightProgress = 0;
        if ([flightStatus.status isEqualToString:@"Landed"])
            flightStatus.flightProgress = 1;
        else if ([flightStatus.status isEqualToString:@"En-Route"]){
            NSDate *flightStartUTC = [flightStatsUTCDF dateFromString:[[operationalTimes objectForKey:@"estimatedGateDeparture"] objectForKey:@"dateUtc"]];
            NSDate *flightEndUTC = [flightStatsUTCDF dateFromString:[[operationalTimes objectForKey:@"estimatedGateArrival"] objectForKey:@"dateUtc"]];
            NSDate *currTimeUTC = [NSDate date];

            NSLog(@"flightStartUTC: %@",flightStartUTC);
            NSLog(@"flightEndUTC: %@",flightEndUTC);
            NSLog(@"currTimeUTC: %@",currTimeUTC);
            
            NSTimeInterval flightDuration = [flightEndUTC timeIntervalSinceDate:flightStartUTC];
            NSTimeInterval flightElapsed = [currTimeUTC timeIntervalSinceDate:flightStartUTC];
            flightStatus.flightProgress = flightElapsed / flightDuration;
         
            NSTimeInterval timeRemaining = [flightEndUTC timeIntervalSinceDate:currTimeUTC];
            int hoursRemaining = timeRemaining / 3600;
            int minutesRemaining = (timeRemaining - hoursRemaining*3600)/60;
            
            flightStatus.status = [NSString stringWithFormat:@"%@ (%d hours, %d minutes remaining)",flightStatus.status,hoursRemaining,minutesRemaining];
        }
        
        
        flightStatus.departureAirport = [currFlightStatusJSON objectForKey:@"departureAirportFsCode"];
        flightStatus.arrivalAirport = [currFlightStatusJSON objectForKey:@"arrivalAirportFsCode"];

        flightStatus.departureCity = [airportCitiesDict objectForKey:flightStatus.departureAirport];
        flightStatus.arrivalCity = [airportCitiesDict objectForKey:flightStatus.arrivalAirport];

        
        
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
        
        
        flightStatus.departureTerminal = ([airportResources objectForKey:@"departureTerminal"]) ? [airportResources objectForKey:@"departureTerminal"] : @"N/A";
        flightStatus.departureGate = ([airportResources objectForKey:@"departureGate"]) ? [airportResources objectForKey:@"departureGate"] : @"N/A";
        flightStatus.arrivalTerminal = ([airportResources objectForKey:@"arrivalTerminal"]) ? [airportResources objectForKey:@"arrivalTerminal"] : @"N/A";
        flightStatus.arrivalGate = ([airportResources objectForKey:@"arrivalGate"]) ? [airportResources objectForKey:@"arrivalGate"] : @"N/A";


        // add the new flight status to the array of statuses
        [flightStatusesArray addObject:flightStatus];
    }
    
    flightStatusSearch.flightStatusesArray = [[NSArray alloc] initWithArray:flightStatusesArray];
    flightStatusSearch.lastUpdated = [NSDate date];
    
    
    // return the results back to the view controller (make sure it's on the main thread since UI will be updated)
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate didReceiveFlightStatuses:flightStatusSearch];
    });
}



- (void)requestFailedWithError:(NSError *)error{
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate fetchingFlightStatusesFailedWithError:error];
    });

}







@end
