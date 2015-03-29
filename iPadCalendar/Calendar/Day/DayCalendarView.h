//
//  DayCalendarView.h
//  InTraining
//
//  Created by tmachc on 14-9-22.
//  Copyright (c) 2014年 crab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayView.h"

typedef enum {
    FirstDayView = 1000,
    SecondDayView
} StateDayView;

@interface DayCalendarView : UIView {
    NSArray *_weekNames1;
    NSArray *_weekNames;
    NSInteger weekday;
    CGFloat contentHeight;
    CGFloat contentWidth;
}

@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSDateComponents *components;
@property (nonatomic, strong) NSDate *calendarDate;
@property (nonatomic, assign) NSInteger todayMonth;
@property (nonatomic, assign) NSInteger todayYear;
@property (nonatomic, assign) NSInteger todayDate;
@property (nonatomic, strong) UILabel *labOverToday;
@property (nonatomic, assign) StateDayView currentDayView;
@property (nonatomic, assign) StateWeekNameView currentWeekNameView;

@property (nonatomic, strong) UIView *weekNameView;
@property (nonatomic, strong) UIView *nextWeekNameView;
@property (nonatomic, strong) DayView *dayView;
@property (nonatomic, strong) DayView *nextDayView;

@property (nonatomic, strong) UIScrollView *scrBg;
@property (nonatomic, strong) UIView *viewContent;
@property (nonatomic, strong) UIImageView *imgTime;
@property (nonatomic, strong) UIView *viewTodayTime;
@property (nonatomic, strong) UILabel *labelTime;

- (void)gotoToday;
- (void)addDayData;

@end
