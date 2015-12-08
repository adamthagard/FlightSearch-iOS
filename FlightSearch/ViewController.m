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

    // initialize communicator to interact with flight stats API and return results here
    _communicator = [[FlightStatsCommunicator alloc] init];
    _communicator.delegate = self;
    
    // update date textfield to today's date
    [self updateDateTextField:[NSDate date]];
    
    // set up date picker keyboard for date textfield
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker addTarget:self action:@selector(dateUpdated:) forControlEvents:UIControlEventValueChanged];
    [dateTextField setInputView:datePicker];

    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Today" style:UIBarButtonItemStylePlain target:self action:@selector(setDatePickerToToday)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithDatePicker)],
                           nil];
    [numberToolbar sizeToFit];
    
    dateTextField.inputAccessoryView = numberToolbar;
    
}

- (void) dateUpdated:(UIDatePicker *)datePicker {
    [self updateDateTextField:datePicker.date];
}

- (void)updateDateTextField:(NSDate*)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, MMM. d, yyyy"];
    dateTextField.text = [formatter stringFromDate:date];
    
    selectedDate = date;
}

-(void) setDatePickerToToday{
    [(UIDatePicker*)dateTextField.inputView setDate:[NSDate date]];
    [self updateDateTextField:[NSDate date]];
}

-(void) doneWithDatePicker{
    [dateTextField resignFirstResponder];
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

#pragma UI input

- (IBAction)searchFlights:(id)sender{

    // resign keyboard
    [self.view endEditing:YES];
    
    
    FlightStatusSearch *newFlightStatusSearch = [[FlightStatusSearch alloc] init];
    newFlightStatusSearch.airlineCode = airlineCodeTextField.text;
    newFlightStatusSearch.flightNumber = flightNumberTextField.text;
    newFlightStatusSearch.searchDate = selectedDate;
    
//    [self.communicator searchFlightsWithAirline:airlineCodeTextField.text flightNumber:flightNumberTextField.text date:selectedDate];
    [self.communicator searchFlights:newFlightStatusSearch];
    
    
//    uivi
}

- (IBAction)resignKeyboard:(id)sender{
    [self.view endEditing:YES];
}

#pragma FlightStatsCommunicatorDelegate

- (void)didReceiveFlightStatuses:(FlightStatusSearch *)completedFlightStatusSearch{

    FlightsTableViewController *flightsVC = [[FlightsTableViewController alloc] initWithFlightSearchResults:completedFlightStatusSearch];
    [self.navigationController pushViewController:flightsVC animated:YES];
}


- (void)fetchingFlightStatusesFailedWithError:(NSError *)error{
    NSLog(@"ERROR");
}


@end
