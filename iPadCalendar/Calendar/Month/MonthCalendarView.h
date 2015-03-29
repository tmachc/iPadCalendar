//
//  MonthCalendarView.h
//  InTraining
//
//  Created by tmachc on 14-9-15.
//  Copyright (c) 2014年 crab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthView.h"

typedef enum {
    FirstMonthView = 1000,
    SecondMonthView
} StateMonthView;

@interface MonthCalendarView : UIView {
    MonthView *monthView;
    MonthView *leftMonthView;
}

@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSDateComponents *components;
@property (nonatomic, strong) NSDate *calendarDate;
@property (nonatomic, assign) StateMonthView currentMonthView;
@property (nonatomic,assign) NSInteger todayMonth;
@property (nonatomic,assign) NSInteger todayYear;
@property (nonatomic,assign) NSInteger todayDate;
@property (nonatomic,strong) UILabel *labOverToday;

- (void)gotoToday;
- (void)addMonthData;

@end
