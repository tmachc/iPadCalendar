//
//  WeekCalendarView.h
//  InTraining
//
//  Created by tmachc on 14-9-17.
//  Copyright (c) 2014年 crab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeekView.h"

typedef enum {
    FirstWeekView = 1000,
    SecondWeekView
} StateWeekView;

@interface WeekCalendarView : UIView  {
    WeekView *weekView;
    WeekView *leftWeekView;
    NSInteger weekday;
    NSArray *_weekNames;
    CGFloat contentHeight;
    CGFloat contentWidth;
    NSString *weekStr;
}

@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSDateComponents *components;
@property (nonatomic, strong) NSDate *calendarDate;
@property (nonatomic, assign) NSInteger todayMonth;
@property (nonatomic, assign) NSInteger todayYear;
@property (nonatomic, assign) NSInteger todayDate;
@property (nonatomic,strong) UILabel *labOverToday;
@property (nonatomic, assign) StateWeekView currentWeekView;
@property (nonatomic, assign) StateWeekNameView currentWeekNameView;


@property (nonatomic, strong) UIScrollView *scrBg;
@property (nonatomic, strong) UIView *viewContent;
@property (nonatomic, strong) UIImageView *imgTime;
@property (nonatomic, strong) UIImageView *todayState;
@property (nonatomic, strong) UIView *viewTodayTime;
@property (nonatomic, strong) UILabel *labelTime;
@property (nonatomic, strong) UIView *weekNameView;
@property (nonatomic, strong) UIView *nextWeekNameView;

- (void)gotoToday;
- (void)addWeekData;

@end
