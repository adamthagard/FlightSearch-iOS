//
//  FlightStatusTableViewCell.h
//  FlightSearch
//
//  Created by Adam Thagard on 2015-12-03.
//  Copyright (c) 2015 adamthagard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlightStatusTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *statusLabel;

@property (strong, nonatomic) UILabel *departureAirportLabel;
@property (strong, nonatomic) UILabel *arrivalAirportLabel;

@property (strong, nonatomic) UILabel *departureCityLabel;
@property (strong, nonatomic) UILabel *arrivalCityLabel;

@property (strong, nonatomic) UILabel *departureDateLabel;
@property (strong, nonatomic) UILabel *arrivalDateLabel;

@property (strong, nonatomic) UILabel *departureTimeLabel;
@property (strong, nonatomic) UILabel *arrivalTimeLabel;

@property (strong, nonatomic) UILabel *departureScheduledTimeLabel;
@property (strong, nonatomic) UILabel *arrivalScheduledTimeLabel;

@property (strong, nonatomic) UILabel *departureGateLabel;
@property (strong, nonatomic) UILabel *arrivalGateLabel;

@property (strong, nonatomic) UILabel *departureTerminalLabel;
@property (strong, nonatomic) UILabel *arrivalTerminalLabel;

@property (strong, nonatomic) UIView *circleView1;
@property (strong, nonatomic) UIView *circleView2;
@property (strong, nonatomic) UIView *lineView1;
@property (strong, nonatomic) UIView *lineView2;

@property (strong, nonatomic) UIImageView *airplaneImageView;

- (void)drawFlightVisualWithCellFrame:(CGRect)cellFrame progress:(float)progress;
- (void)updatePunctualityColor:(NSString*)punctuality;

@end
