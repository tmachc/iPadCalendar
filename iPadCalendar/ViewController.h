//
//  ViewController.h
//  iPadCalendar
//
//  Created by 韩冲 on 14/12/21.
//  Copyright (c) 2014年 tmachc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayCalendarView.h"
#import "MonthCalendarView.h"
#import "WeekCalendarView.h"
#import "YearCalendarView.h"

typedef enum {
    StateDayBtn = 400,
    StateWeekBtn,
    StateMonthBtn,
    StateYearBtn
} StateCalendarBtn;

@interface ViewController : UIViewController {
    NSArray *aryBtn;
    StateCalendarBtn stateCalendarBtn;
}

@property (nonatomic, strong) UIView *viewCalendarNavigation;
@property (nonatomic, strong) UIButton *btnDay;
@property (nonatomic, strong) UIButton *btnWeek;
@property (nonatomic, strong) UIButton *btnMonth;
@property (nonatomic, strong) UIButton *btnYear;
@property (nonatomic, strong) UIButton *btnToday;
@property (nonatomic, strong) UILabel *labTodayMonth;

@property (nonatomic, strong) YearCalendarView *yearCalendarView;
@property (nonatomic, strong) MonthCalendarView *monthCalendarView;
@property (nonatomic, strong) WeekCalendarView *weekCalendarView;
@property (nonatomic, strong) DayCalendarView *dayCalendarView;

@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSDate *calendarDate;
@property (nonatomic, strong) NSDateComponents *components;
@property (nonatomic, assign) NSInteger todayMonth;
@property (nonatomic, assign) NSInteger todayYear;
@property (nonatomic, assign) NSInteger todayDate;
@property (nonatomic, assign) NSInteger year;

- (void)setMonthNameLabel:(NSString *)monthName;
- (void)setCalendarYear:(NSInteger)year Month:(NSInteger)month Date:(NSInteger)date;
- (void)gotoMonthCalendar:(int)month;

@end

