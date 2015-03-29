//
//  YearCalendarView.h
//  InTraining
//
//  Created by tmachc on 14-9-18.
//  Copyright (c) 2014年 crab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YearView.h"

typedef enum {
    FirstYearView = 700,
    SecondYearView
} StateYearView;

@interface YearCalendarView : UIView {
    YearView *yearView;
    BOOL isLeft;
}

@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSDateComponents *components;
@property (nonatomic, strong) NSDate *calendarDate;
@property (nonatomic, assign) NSInteger todayMonth;
@property (nonatomic, assign) NSInteger todayYear;
@property (nonatomic, assign) NSInteger todayDate;
@property (nonatomic,strong) UILabel *labOverToday;

@property (nonatomic,strong) UIImageView *imgOverFirst;
@property (nonatomic,strong) UIImageView *imgOverSecond;
@property (nonatomic, assign) StateYearView currentYearView;

- (void)gotoToday;
- (void)addYearData;

@end
