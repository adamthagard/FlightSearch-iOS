//
//  FlightStatusTableViewCell.m
//  FlightSearch
//
//  Created by Adam Thagard on 2015-12-03.
//  Copyright (c) 2015 adamthagard. All rights reserved.
//

#import "FlightStatusTableViewCell.h"

#define EDGE_PADDING 10.0
#define STATUS_HEIGHT 20.0
#define AIRPORT_CODE_HEIGHT 34.0
#define SECONDARY_LABEL_HEIGHT 16.0
#define TERTIARY_LABEL_HEIGHT 12.0
#define TIME_LABEL_HEIGHT 26.0
#define SIDE_OFFSET 94.0
#define CIRCLE_SIZE 10.0
#define LINE_WIDTH 2.0
#define AIRPLANE_IMAGE_SIZE 32.0

@implementation FlightStatusTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Helpers
        CGSize size = self.frame.size;
        float rowYStart = EDGE_PADDING;
        UIColor *myColor = [UIColor colorWithRed:20.0/255.0 green:100.0/255.0 blue:190.0/255.0 alpha:1.0];
        
        // Status Label
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(EDGE_PADDING, rowYStart, size.width - 2*EDGE_PADDING, STATUS_HEIGHT)];
        [self.statusLabel setFont:[UIFont systemFontOfSize:18.0]];
        [self.statusLabel setTextAlignment:NSTextAlignmentLeft];
        [self.statusLabel setTextColor:myColor];
        [self.statusLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
        [self.contentView addSubview:self.statusLabel];
        
        
        // Airport Labels
        rowYStart = rowYStart + STATUS_HEIGHT + EDGE_PADDING;
        
        self.departureAirportLabel = [[UILabel alloc] initWithFrame:CGRectMake(EDGE_PADDING, rowYStart, size.width - 2*EDGE_PADDING, AIRPORT_CODE_HEIGHT)];
        [self.departureAirportLabel setTextAlignment:NSTextAlignmentLeft];
        [self.departureAirportLabel setFont:[UIFont systemFontOfSize:AIRPORT_CODE_HEIGHT]];
        [self.departureAirportLabel setTextColor:[UIColor blackColor]];
        [self.departureAirportLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
        [self.contentView addSubview:self.departureAirportLabel];
        
        self.arrivalAirportLabel = [[UILabel alloc] initWithFrame:CGRectMake(EDGE_PADDING, rowYStart, size.width - 2*EDGE_PADDING, AIRPORT_CODE_HEIGHT)];
        [self.arrivalAirportLabel setTextAlignment:NSTextAlignmentRight];
        [self.arrivalAirportLabel setFont:[UIFont systemFontOfSize:AIRPORT_CODE_HEIGHT]];
        [self.arrivalAirportLabel setTextColor:[UIColor blackColor]];
        [self.arrivalAirportLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
        [self.contentView addSubview:self.arrivalAirportLabel];
        
        
        
        // Path Visual
        self.circleView1 = [[UIView alloc] initWithFrame:CGRectMake(SIDE_OFFSET,rowYStart+AIRPORT_CODE_HEIGHT/2-CIRCLE_SIZE/2,CIRCLE_SIZE,CIRCLE_SIZE)];
        self.circleView1.layer.cornerRadius = 5;
        self.circleView1.backgroundColor = myColor;
        [self.contentView addSubview:self.circleView1];
        
        self.circleView2 = [[UIView alloc] initWithFrame:CGRectMake(size.width - SIDE_OFFSET-CIRCLE_SIZE,rowYStart+AIRPORT_CODE_HEIGHT/2-CIRCLE_SIZE/2,CIRCLE_SIZE,CIRCLE_SIZE)];
        self.circleView2.layer.cornerRadius = 5;
        self.circleView2.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.circleView2];
        
        self.lineView1 = [[UIView alloc] initWithFrame:CGRectMake(SIDE_OFFSET+5,rowYStart+AIRPORT_CODE_HEIGHT/2-1,100,2)];
        self.lineView1.backgroundColor = myColor;
        [self.contentView addSubview:self.lineView1];
        
        self.lineView2 = [[UIView alloc] initWithFrame:CGRectMake(SIDE_OFFSET+5+100,rowYStart+AIRPORT_CODE_HEIGHT/2-1,60,2)];
        self.lineView2.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.lineView2];
        
        self.airplaneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SIDE_OFFSET,rowYStart+AIRPORT_CODE_HEIGHT/2-AIRPLANE_IMAGE_SIZE/2,AIRPLANE_IMAGE_SIZE,AIRPLANE_IMAGE_SIZE)];
        self.airplaneImageView.image = [[UIImage imageNamed:@"airplane_white.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.airplaneImageView.tintColor = myColor;
        self.airplaneImageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.airplaneImageView];
        
        
        
        // City Labels
        rowYStart = rowYStart + AIRPORT_CODE_HEIGHT + EDGE_PADDING;
        
        self.departureCityLabel = [[UILabel alloc] initWithFrame:CGRectMake(EDGE_PADDING, rowYStart, size.width - 2*EDGE_PADDING, SECONDARY_LABEL_HEIGHT)];
        [self.departureCityLabel setTextAlignment:NSTextAlignmentLeft];
        [self.departureCityLabel setFont:[UIFont systemFontOfSize:SECONDARY_LABEL_HEIGHT]];
        [self.departureCityLabel setTextColor:[UIColor darkGrayColor]];
        [self.departureCityLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
        [self.contentView addSubview:self.departureCityLabel];
        
        self.arrivalCityLabel = [[UILabel alloc] initWithFrame:CGRectMake(EDGE_PADDING, rowYStart, size.width - 2*EDGE_PADDING, SECONDARY_LABEL_HEIGHT)];
        [self.arrivalCityLabel setTextAlignment:NSTextAlignmentRight];
        [self.arrivalCityLabel setFont:[UIFont systemFontOfSize:SECONDARY_LABEL_HEIGHT]];
        [self.arrivalCityLabel setTextColor:[UIColor darkGrayColor]];
        [self.arrivalCityLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
        [self.contentView addSubview:self.arrivalCityLabel];
        
        
        
        // Date Labels
        rowYStart = rowYStart + SECONDARY_LABEL_HEIGHT + 2.0;
        
        self.departureDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(EDGE_PADDING, rowYStart, size.width - 2*EDGE_PADDING, SECONDARY_LABEL_HEIGHT)];
        [self.departureDateLabel setTextAlignment:NSTextAlignmentLeft];
        [self.departureDateLabel setFont:[UIFont systemFontOfSize:SECONDARY_LABEL_HEIGHT]];
        [self.departureDateLabel setTextColor:[UIColor darkGrayColor]];
        [self.departureDateLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
        [self.contentView addSubview:self.departureDateLabel];
        
        self.arrivalDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(EDGE_PADDING, rowYStart, size.width - 2*EDGE_PADDING, SECONDARY_LABEL_HEIGHT)];
        [self.arrivalDateLabel setTextAlignment:NSTextAlignmentRight];
        [self.arrivalDateLabel setFont:[UIFont systemFontOfSize:SECONDARY_LABEL_HEIGHT]];
        [self.arrivalDateLabel setTextColor:[UIColor darkGrayColor]];
        [self.arrivalDateLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
        [self.contentView addSubview:self.arrivalDateLabel];
    
        
        
        // Time Labels
        rowYStart = rowYStart + SECONDARY_LABEL_HEIGHT + EDGE_PADDING;
        
        self.departureTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(EDGE_PADDING, rowYStart, size.width - 2*EDGE_PADDING, TIME_LABEL_HEIGHT)];
        [self.departureTimeLabel setTextAlignment:NSTextAlignmentLeft];
        [self.departureTimeLabel setFont:[UIFont systemFontOfSize:TIME_LABEL_HEIGHT]];
        [self.departureTimeLabel setTextColor:[UIColor blackColor]];
        [self.departureTimeLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
        [self.contentView addSubview:self.departureTimeLabel];
        
        self.arrivalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(EDGE_PADDING, rowYStart, size.width - 2*EDGE_PADDING, TIME_LABEL_HEIGHT)];
        [self.arrivalTimeLabel setTextAlignment:NSTextAlignmentRight];
        [self.arrivalTimeLabel setFont:[UIFont systemFontOfSize:TIME_LABEL_HEIGHT]];
        [self.arrivalTimeLabel setTextColor:[UIColor blackColor]];
        [self.arrivalTimeLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
        [self.contentView addSubview:self.arrivalTimeLabel];
        
        
        // Scheduled Time Labels
        rowYStart = rowYStart + TIME_LABEL_HEIGHT ;
        
        self.departureScheduledTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(EDGE_PADDING, rowYStart, size.width - 2*EDGE_PADDING, TERTIARY_LABEL_HEIGHT)];
        [self.departureScheduledTimeLabel setTextAlignment:NSTextAlignmentLeft];
        [self.departureScheduledTimeLabel setFont:[UIFont systemFontOfSize:TERTIARY_LABEL_HEIGHT]];
        [self.departureScheduledTimeLabel setTextColor:[UIColor grayColor]];
        [self.departureScheduledTimeLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
        [self.contentView addSubview:self.departureScheduledTimeLabel];
        
        self.arrivalScheduledTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(EDGE_PADDING, rowYStart, size.width - 2*EDGE_PADDING, TERTIARY_LABEL_HEIGHT)];
        [self.arrivalScheduledTimeLabel setTextAlignment:NSTextAlignmentRight];
        [self.arrivalScheduledTimeLabel setFont:[UIFont systemFontOfSize:TERTIARY_LABEL_HEIGHT]];
        [self.arrivalScheduledTimeLabel setTextColor:[UIColor grayColor]];
        [self.arrivalScheduledTimeLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
        [self.contentView addSubview:self.arrivalScheduledTimeLabel];
        
        
        
        // Terminal Labels
        rowYStart = rowYStart + TERTIARY_LABEL_HEIGHT + EDGE_PADDING;
        
        self.departureTerminalLabel = [[UILabel alloc] initWithFrame:CGRectMake(EDGE_PADDING, rowYStart, size.width - 2*EDGE_PADDING, SECONDARY_LABEL_HEIGHT)];
        [self.departureTerminalLabel setTextAlignment:NSTextAlignmentLeft];
        [self.departureTerminalLabel setFont:[UIFont systemFontOfSize:SECONDARY_LABEL_HEIGHT]];
        [self.departureTerminalLabel setTextColor:[UIColor darkGrayColor]];
        [self.departureTerminalLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
        [self.contentView addSubview:self.departureTerminalLabel];
        
        self.arrivalTerminalLabel = [[UILabel alloc] initWithFrame:CGRectMake(EDGE_PADDING, rowYStart, size.width - 2*EDGE_PADDING, SECONDARY_LABEL_HEIGHT)];
        [self.arrivalTerminalLabel setTextAlignment:NSTextAlignmentRight];
        [self.arrivalTerminalLabel setFont:[UIFont systemFontOfSize:SECONDARY_LABEL_HEIGHT]];
        [self.arrivalTerminalLabel setTextColor:[UIColor darkGrayColor]];
        [self.arrivalTerminalLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
        [self.contentView addSubview:self.arrivalTerminalLabel];
        
        
        // Gate Labels
        rowYStart = rowYStart + SECONDARY_LABEL_HEIGHT + 2.0;
        
        self.departureGateLabel = [[UILabel alloc] initWithFrame:CGRectMake(EDGE_PADDING, rowYStart, size.width - 2*EDGE_PADDING, SECONDARY_LABEL_HEIGHT)];
        [self.departureGateLabel setTextAlignment:NSTextAlignmentLeft];
        [self.departureGateLabel setFont:[UIFont systemFontOfSize:SECONDARY_LABEL_HEIGHT]];
        [self.departureGateLabel setTextColor:[UIColor darkGrayColor]];
        [self.departureGateLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
        [self.contentView addSubview:self.departureGateLabel];
        
        self.arrivalGateLabel = [[UILabel alloc] initWithFrame:CGRectMake(EDGE_PADDING, rowYStart, size.width - 2*EDGE_PADDING, SECONDARY_LABEL_HEIGHT)];
        [self.arrivalGateLabel setTextAlignment:NSTextAlignmentRight];
        [self.arrivalGateLabel setFont:[UIFont systemFontOfSize:SECONDARY_LABEL_HEIGHT]];
        [self.arrivalGateLabel setTextColor:[UIColor darkGrayColor]];
        [self.arrivalGateLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
        [self.contentView addSubview:self.arrivalGateLabel];
        
        
        
        

    }
    
    return self;
}

- (void)drawFlightVisualWithCellFrame:(CGRect)cellFrame progress:(float)progress{
    float centerY = EDGE_PADDING + STATUS_HEIGHT + EDGE_PADDING + AIRPORT_CODE_HEIGHT/2;
    
    float startX = SIDE_OFFSET;
    float endX = cellFrame.size.width - SIDE_OFFSET;
    float currX = startX + progress * ((endX - AIRPLANE_IMAGE_SIZE) - startX);
    
    [self.circleView1 setFrame:CGRectMake(startX,centerY-CIRCLE_SIZE/2,CIRCLE_SIZE,CIRCLE_SIZE)];
    [self.circleView2 setFrame:CGRectMake(endX - CIRCLE_SIZE,centerY-CIRCLE_SIZE/2,CIRCLE_SIZE,CIRCLE_SIZE)];

    [self.lineView1 setFrame:CGRectMake(startX + CIRCLE_SIZE/2,centerY-LINE_WIDTH/2,currX - (startX + CIRCLE_SIZE/2),LINE_WIDTH)];
    [self.lineView2 setFrame:CGRectMake(currX,centerY-LINE_WIDTH/2,(endX - CIRCLE_SIZE/2) - currX,LINE_WIDTH)];

    [self.airplaneImageView setFrame:CGRectMake(currX,centerY-AIRPLANE_IMAGE_SIZE/2,AIRPLANE_IMAGE_SIZE,AIRPLANE_IMAGE_SIZE)];
}


- (void)updatePunctualityColor:(NSString*)punctuality{
    
    UIColor *myColor = [UIColor colorWithRed:67.0/255.0 green:148.0/255.0 blue:111.0/255.0 alpha:1.0];
    [self.arrivalTimeLabel setTextColor:[UIColor blackColor]];

    if ([punctuality isEqualToString:@"Delayed"]){
        myColor = [UIColor colorWithRed:221.0/255.0 green:75.0/255.0 blue:56.0/255.0 alpha:1.0];
        [self.arrivalTimeLabel setTextColor:myColor];
    }

    [self.statusLabel setTextColor:myColor];
    self.circleView1.backgroundColor = myColor;
    self.lineView1.backgroundColor = myColor;
    self.airplaneImageView.tintColor = myColor;


}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
