//
//  MonthView.h
//  InTraining
//
//  Created by tmachc on 14-9-15.
//  Copyright (c) 2014年 crab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthDayView.h"

@interface MonthView : UIView <UIAlertViewDelegate>
{
    NSArray *_weekNames;
}

@property (nonatomic,strong) NSDate *calendarDate;
@property (nonatomic,strong) NSCalendar *gregorian;
@property (nonatomic,strong) UILabel *monthLabel;
@property (nonatomic,strong) NSDateComponents *components;
@property (nonatomic,assign) NSInteger selectedMonth;
@property (nonatomic,assign) NSInteger selectedYear;
@property (nonatomic,assign) NSInteger selectedDate;

- (void)addMonthData;

@end
