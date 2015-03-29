//
//  MonthCalendarView.m
//  InTraining
//
//  Created by tmachc on 14-9-15.
//  Copyright (c) 2014年 crab. All rights reserved.
//

#import "MonthCalendarView.h"

@implementation MonthCalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (UILabel *)labOverToday
{
    if (!_labOverToday) {
        _labOverToday = [[UILabel alloc] initWithFrame:CGRectMake(0, 29, 1024, 524 - 29)];
        _labOverToday.font = [UIFont boldSystemFontOfSize:40.0f];
        _labOverToday.textAlignment = NSTextAlignmentCenter;
        _labOverToday.alpha = 0.0f;
        _labOverToday.backgroundColor = [UIColor whiteColor];
    }
    return _labOverToday;
}

- (void)drawRect:(CGRect)rect
{
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor clearColor];
    //当前的日历
    monthView= [[MonthView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    monthView.tag = FirstMonthView;
    _currentMonthView = FirstMonthView;
    [self setMonthView:monthView];
    
    UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [monthView addGestureRecognizer:swipeleft];
    UISwipeGestureRecognizer * swipeRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
    [monthView addGestureRecognizer:swipeRight];
    
    [self addSubview:monthView];
    
    //上个月的日历
    leftMonthView = [[MonthView alloc]initWithFrame:CGRectMake(-1024, 0, rect.size.width, rect.size.height)];
    leftMonthView.tag = SecondMonthView;
    [self setMonthView:leftMonthView];
    
    _components.month --;
    leftMonthView.calendarDate = [leftMonthView.gregorian dateFromComponents:_components];
    [self addSubview:leftMonthView];
    
    _components.month ++;
    //添加遮罩
    [self addSubview:self.labOverToday];
    self.labOverToday.text = [NSString stringWithFormat:@"%d 年 %d 月",(int)_todayYear,(int)_todayMonth];
    ViewController *viewController = (ViewController *)[CommonTool findNearestViewController:self];
    [viewController setMonthNameLabel:[NSString stringWithFormat:@"%d 年 %d 月",(int)_components.year,(int)_components.month]];
    if (self.components.year == _todayYear && self.components.month == _todayMonth) {
        [viewController setCalendarYear:self.components.year Month:self.components.month Date:_todayDate];
    } else {
        [viewController setCalendarYear:self.components.year Month:self.components.month Date:1];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        monthView.monthLabel.alpha = 0.0f;
    });
}

#pragma mark - swipe

- (void)swipe:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft || swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        // 显示出遮罩层
        
        // view1 为当前的月份， view2 为即将要显示的月份
        MonthView *view1 = (MonthView *)[self viewWithTag:_currentMonthView];
        view1.monthLabel.alpha = 0.8f;
        MonthView *view2 = (MonthView *)[self viewWithTag:(_currentMonthView == FirstMonthView ? SecondMonthView : FirstMonthView)];
        view2.monthLabel.alpha = 0.8f;
        
        // 设置view2
        view2.frame = CGRectMake((swipe.direction == UISwipeGestureRecognizerDirectionLeft ? 1024.0f : -1024.0f) , 0, view2.frame.size.width, view2.frame.size.height);
        view2.calendarDate = [view2.gregorian dateFromComponents:_components];
        
        // 以view1为基础，修改view2的时间
        view2.components = [view1.gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:view1.calendarDate];
        swipe.direction == UISwipeGestureRecognizerDirectionLeft ? (view2.components.month ++) : (view2.components.month --);
        NSLog(@"第 %d 月",(int)view2.components.month);
        
        if ((int)view2.components.month == 13) {
            // 拿后一年的数据
        }
        if ((int)view2.components.month == 0) {
            // 拿前一年的数据
        }
        
        view2.calendarDate = [view2.gregorian dateFromComponents:view2.components];
        for (id item in view2.subviews) {
            [CommonTool removeAllSubviews:item];
        }
        [view2 setNeedsDisplay];
        
        //移动view的动画
        [UIView animateWithDuration:0.5 animations:^{
            CGRect rect1 = view1.frame;
            CGRect rect2 = view2.frame;
            if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
                rect1.origin.x -= 1024.0f;
                rect2.origin.x -= 1024.0f;
            } else {
                rect1.origin.x += 1024.0f;
                rect2.origin.x += 1024.0f;
            }
            view1.frame = rect1;
            view2.frame = rect2;
        } completion:^(BOOL finished) {
            // view1 移除手势
            for (UISwipeGestureRecognizer *swip in view1.gestureRecognizers) {
                [view1 removeGestureRecognizer:swip];
            }
            
            // view2 添加手势
            [(ViewController *)[CommonTool findNearestViewController:self] setMonthNameLabel:view2.monthLabel.text];
            if (view2.components.year == _todayYear && view2.components.month == _todayMonth) {
                [(ViewController *)[CommonTool findNearestViewController:self] setCalendarYear:view2.components.year Month:view2.components.month Date:_todayDate];
            } else {
                [(ViewController *)[CommonTool findNearestViewController:self] setCalendarYear:view2.components.year Month:view2.components.month Date:1];
            }
            UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
            swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
            [view2 addGestureRecognizer:swipeleft];
            UISwipeGestureRecognizer * swipeRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
            swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
            [view2 addGestureRecognizer:swipeRight];
            
            // 修改_currentMonthView的值为当前view的tag
            if (_currentMonthView == FirstMonthView) {
                _currentMonthView = SecondMonthView;
            } else {
                _currentMonthView = FirstMonthView;
            }
            
            // 隐藏遮罩层
            view1.monthLabel.alpha = 0.0f;
            view2.monthLabel.alpha = 0.0f;
        }];
    }
}

- (void)gotoToday
{
    [UIView animateWithDuration:0.5f animations:^{
        self.labOverToday.alpha = 0.8f;
    } completion:^(BOOL finished) {
        //修改当前的view 为本月
        MonthView *view = (MonthView *)[self viewWithTag:_currentMonthView];
        view.gregorian = [NSCalendar currentCalendar]; //NSChineseCalendar是农历。。。
        view.calendarDate = [NSDate date];
        view.components = [view.gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:view.calendarDate];
        for (id item in view.subviews) {
            [CommonTool removeAllSubviews:item];
        }
        [view setNeedsDisplay];
        [UIView animateWithDuration:0.5f animations:^{
            [(ViewController *)[CommonTool findNearestViewController:self] setMonthNameLabel:self.labOverToday.text];
            self.labOverToday.alpha = 0.0f;
            view.monthLabel.alpha = 0.0f;
        }];
    }];
}

#pragma mark - function

- (void)setMonthView:(MonthView *)month
{
    [month setBackgroundColor:[UIColor clearColor]];
    
    month.gregorian = _calendar;
    month.calendarDate = _calendarDate;
    
    month.selectedDate  = _todayDate;
    month.selectedMonth = _todayMonth;
    month.selectedYear = _todayYear;
}

- (void)addMonthData
{
    MonthView *view = (MonthView *)[self viewWithTag:_currentMonthView];
    [view addMonthData];
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    _calendar = nil;
    _components = nil;
    _calendarDate = nil;
    _labOverToday = nil;
    monthView = nil;
    leftMonthView = nil;
}

@end
