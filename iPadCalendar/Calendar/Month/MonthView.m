//
//  MonthView.m
//  InTraining
//
//  Created by tmachc on 14-9-15.
//  Copyright (c) 2014年 crab. All rights reserved.
//

#import "MonthView.h"

@implementation MonthView

#define OtherMonthColor RGBCOLOR(231.0f, 231.0f, 231.0f)
#define WeekendColor RGBCOLOR(238.0f, 238.0f, 238.0f)
#define WeekDayColor [UIColor whiteColor]
#define ToDayColor RGBCOLOR(210.0f, 237.0f, 248.0f)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UILabel *)monthLabel
{
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 29.0f, self.frame.size.width, self.frame.size.height - 29.0f)];
        _monthLabel.font = [UIFont boldSystemFontOfSize:40.0f];
        //        _monthLabel.font = [UIFont boldSystemFontOfSize:40.0f];
        _monthLabel.textAlignment = NSTextAlignmentCenter;
        _monthLabel.alpha = 0.8f;
        _monthLabel.backgroundColor = [UIColor whiteColor];
    }
    return _monthLabel;
}

- (void)drawRect:(CGRect)rect
{
//    haveAddData = false;
    CGFloat width = 146.0f;
    CGFloat height = 99.0f;
    CGFloat originX = 1.0f;
    CGFloat originY = 29.0f;

    self.backgroundColor = [UIColor clearColor];
    
    _weekNames = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    _components = [self.gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    _components.day = 1;
    NSDate *firstDayOfMonth = [self.gregorian dateFromComponents:_components];
    NSDateComponents *comps = [self.gregorian components:NSWeekdayCalendarUnit fromDate:firstDayOfMonth];
    NSInteger weekday = [comps weekday];
    
    weekday  = weekday - 1;  //默认是周六开始 -1为周日开始 weekday表示1号前面有weekday个空位置
    
    if(weekday < 0) {
        weekday += 7;
    }
    
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self.calendarDate];
    
    NSInteger columns = 7;
    NSInteger monthLength = days.length;
    // 如果一个月有6周 修改高度
    if ((monthLength + weekday) > 35) {
        originY = 30.0f;
        height = 82.0f;
    } else {
        originY = 29.0f;
        height = 99.0f;
    }
    
    //添加周几的标题
    for (int i =0; i<_weekNames.count; i++) {
        UILabel *weekNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(originX+(width*(i%columns)), 0, width, originY)];
        weekNameLabel.text = [_weekNames objectAtIndex:i];
        weekNameLabel.textAlignment = NSTextAlignmentCenter;
        if (i == 0 || i == _weekNames.count-1) {
            weekNameLabel.textColor = RGBCOLOR(153.0f, 153.0f, 153.0f);
        } else {
            weekNameLabel.textColor = [UIColor whiteColor];
        }
        weekNameLabel.font = [UIFont boldSystemFontOfSize:15.0f];
        weekNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:weekNameLabel];
        weekNameLabel = nil;
    }
    
    UIColor *color = WeekDayColor;
    // 添加当月的每一天
    for (int i = 0; i<monthLength; i++) {
        NSInteger offsetX = (width*((i+weekday)%columns));
        NSInteger offsetY = (height *((i+weekday)/columns));
        
        MonthDayView *dayView = [[MonthDayView alloc] initWithFrame:CGRectMake(originX+offsetX, originY+offsetY, width, height)];
        dayView.tag = i+1 + 300;
        
        [self addSubview:dayView];
        // 判断是不是周末
        if (((i+weekday)%columns) == 0 || ((i+weekday)%columns) == 6) {
            color = WeekendColor;
        } else {
            color = WeekDayColor;
        }
        // 判断是不是今天
        if (_components.month == _selectedMonth && _components.year == _selectedYear && i+1 == _selectedDate) {
            color = ToDayColor;
            [dayView setDayNum:i+1 AndColor:color AndAlpha:0.98f];
            [dayView isToday];
        } else {
            [dayView setDayNum:i+1 AndColor:color AndAlpha:0.98f];
        }
        
        dayView = nil;
    }
    
    NSDateComponents *previousMonthComponents = [self.gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
    previousMonthComponents.month -= 1;
    NSDate *previousMonthDate = [self.gregorian dateFromComponents:previousMonthComponents];
    NSRange previousMonthDays = [c rangeOfUnit:NSDayCalendarUnit
                                        inUnit:NSMonthCalendarUnit
                                       forDate:previousMonthDate];
    NSInteger maxDate = previousMonthDays.length - weekday + 1;
    
    color = OtherMonthColor;
    
    //添加上个月的要显示的
    for (int i=0; i<weekday; i++) {
        NSInteger offsetX = (width*(i%columns));
        NSInteger offsetY = (height *(i/columns));
        
        MonthDayView *monthDayView = [[MonthDayView alloc] initWithFrame:CGRectMake(originX+offsetX, originY+offsetY, width, height)];
        [monthDayView setDayNum:(int)maxDate + i AndColor:color AndAlpha:0.95f];
        
        [self addSubview:monthDayView];
        monthDayView = nil;
    }
    //添加下个月的要显示的
    NSInteger remainingDays = 35 - (monthLength + weekday);
    if ((monthLength + weekday) > 35) {
        // 如果一个月有6周
        remainingDays = 42 - (monthLength + weekday);
    }
    for (int i = 0; i<remainingDays; i++) {
        NSInteger offsetX = (width*((monthLength + weekday + i) %columns));
        NSInteger offsetY = (height *((monthLength + weekday + i)/columns));
        
        MonthDayView *monthDayView = [[MonthDayView alloc] initWithFrame:CGRectMake(originX+offsetX, originY+offsetY, width, height)];
        [monthDayView setDayNum:i+1 AndColor:color AndAlpha:0.95f];
        
        [self addSubview:monthDayView];
        monthDayView = nil;
    }
    
    [self addSubview:self.monthLabel];
    _monthLabel.text = [NSString stringWithFormat:@"%d 年 %d 月",(int)_components.year,(int)_components.month];
    [self addMonthData];
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    _calendarDate = nil;
    _gregorian = nil;
    _monthLabel = nil;
    _components = nil;
}

- (void)addMonthData
{
    
}

@end
