//
//  YearCalendarView.m
//  InTraining
//
//  Created by tmachc on 14-9-18.
//  Copyright (c) 2014年 crab. All rights reserved.
//

#import "YearCalendarView.h"

@implementation YearCalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UIImageView *)imgOverFirst
{
    if (!_imgOverFirst) {
        _imgOverFirst = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _imgOverFirst.image = ImageNamed(@"img_yearOverBg.jpg");
        _imgOverFirst.tag = FirstYearView + 10;
        UILabel *yearName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        yearName.font = [UIFont boldSystemFontOfSize:40.0f];
        yearName.textAlignment = NSTextAlignmentCenter;
        yearName.tag = FirstYearView + 20;
        [_imgOverFirst addSubview:yearName];
        _imgOverFirst.alpha = 0.0f;
    }
    return _imgOverFirst;
}

- (UIImageView *)imgOverSecond
{
    if (!_imgOverSecond) {
        _imgOverSecond = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _imgOverSecond.image = ImageNamed(@"img_yearOverBg.jpg");
        _imgOverSecond.tag = SecondYearView + 10;
        UILabel *yearName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        yearName.tag = SecondYearView + 20;
        yearName.font = [UIFont boldSystemFontOfSize:40.0f];
        yearName.textAlignment = NSTextAlignmentCenter;
        [_imgOverSecond addSubview:yearName];
        _imgOverSecond.alpha = 0.0f;
    }
    return _imgOverSecond;
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
    isLeft = false;
    //当前的年历
    yearView = [[YearView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    _currentYearView = FirstYearView;
    [self setYearView:yearView];
    [self addSubview:yearView];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
    [yearView addGestureRecognizer:swipeLeft];
    [yearView addGestureRecognizer:swipeRight];
    
    
    //添加遮罩
    [self addSubview:self.labOverToday];
    self.labOverToday.text = [NSString stringWithFormat:@"%d 年",(int)_todayYear];
    [(ViewController *)[CommonTool findNearestViewController:self] setMonthNameLabel:[NSString stringWithFormat:@"%d 年",(int)_components.year]];
    
    [self addSubview:self.imgOverFirst];
    [self addSubview:self.imgOverSecond];
    UILabel *label1 = (UILabel *)[self viewWithTag:_currentYearView + 20];
    label1.text = [NSString stringWithFormat:@"%d 年",(int)_components.year];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        yearView.yearLabel.alpha = 0.0f;
//    });
}

#pragma mark - function

- (void)setYearView:(YearView *)year
{
    //    week.calendardelegate = self;
    [year setBackgroundColor:[UIColor lightGrayColor]];
    
    year.calendar = _calendar;
    year.calendarDate = _calendarDate;
    year.components = _components;
    
    year.todayDate  = _todayDate;
    year.todayMonth = _todayMonth;
    year.todayYear = _todayYear;
    
    // 判断本周是否包含今天
    year.components = [year.calendar components:(NSEraCalendarUnit | NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:year.calendarDate];
    
    if (year.components.year == _todayYear) {
        
    }
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    _calendar = nil;
    _components = nil;
    _calendarDate = nil;
    _labOverToday = nil;
    yearView = nil;
    _imgOverFirst = nil;
    _imgOverSecond = nil;
}

- (void)addYearData
{
//    YearView *view = (YearView *)[self viewWithTag:_currentYearView];
    [yearView addYearData];
}

#pragma mark - swipe

- (void)swipe:(UISwipeGestureRecognizer *)swipe
{
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft || swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        // 显示出遮罩层
        
        // view1 为当前的月份， view2 为即将要显示的月份
        UIImageView *view1 = (UIImageView *)[self viewWithTag:_currentYearView + 10];
        UIImageView *view2 = (UIImageView *)[self viewWithTag:(_currentYearView == FirstYearView ? SecondYearView + 10 : FirstYearView + 10)];
        view2.frame = CGRectMake((swipe.direction == UISwipeGestureRecognizerDirectionLeft ? 1024.0f : -1024.0f) , 0, view2.frame.size.width, view2.frame.size.height);
        
        view1.alpha = 1.0f;
        view2.alpha = 1.0f;
        
        UILabel *label1 = (UILabel *)[self viewWithTag:_currentYearView + 20];
        UILabel *label2 = (UILabel *)[self viewWithTag:(_currentYearView == FirstYearView ? (SecondYearView + 20) : (FirstYearView + 20))];
        label1.text = [NSString stringWithFormat:@"%d 年",(int)_components.year];
        label2.text = [NSString stringWithFormat:@"%d 年",(swipe.direction == UISwipeGestureRecognizerDirectionLeft ? ((int)_components.year + 1) : ((int)_components.year - 1))];
        
        NSLog(@"start");
        yearView.viewSummary.hidden = YES;
        
        //移动view的动画
        [UIView animateWithDuration:0.5 animations:^{
            CGRect rect1 = view1.frame;
            CGRect rect2 = view2.frame;
            NSLog(@"view1-111-->>%@",view1);
            NSLog(@"view2--222->>%@",view2);
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
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            
            NSLog(@"end");
            
                // 重新加载年历
                _components = [_calendar components:(NSEraCalendarUnit | NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:_calendarDate];
                swipe.direction == UISwipeGestureRecognizerDirectionLeft ? (_components.year ++) : (_components.year --);
                
                //取 1月1号
                _components.month = 1;
                _components.day = 1;
                
                // 更新下view2的日期
                _calendarDate = [_calendar dateFromComponents:_components];
                _components = [_calendar components:(NSEraCalendarUnit | NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:_calendarDate];
                
                yearView.components = _components;
                yearView.calendarDate = _calendarDate;
            ViewController *viewController = (ViewController *)[CommonTool findNearestViewController:self];
                [viewController setMonthNameLabel:[NSString stringWithFormat:@"%d 年",(int)_components.year]];
                
                // 判断这周是不是包含今天 如果包含 取今天
                if (yearView.components.year == _todayYear) {
                    // 更新下view2的日期
                    yearView.calendarDate = [NSDate date];
                    yearView.components = [yearView.calendar components:(NSEraCalendarUnit | NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:yearView.calendarDate];
                    [viewController setCalendarYear:_todayYear Month:_todayMonth Date:_todayDate];
                } else {
                    [viewController setCalendarYear:yearView.components.year Month:1 Date:1];
                }
            
            // 重新加载一下view
            for (id item in yearView.subviews) {
                [CommonTool removeAllSubviews:item];
            }
            [yearView setNeedsDisplay];
                
            NSLog(@"end1");
//            yearView.viewSummary.hidden = NO;
            
//            });
            
            view1.alpha = 0.0f;
            view2.alpha = 0.0f;
        }];
        
        // 修改_currentMonthView的值为当前view的tag
        _currentYearView == FirstYearView ? (_currentYearView = SecondYearView) : (_currentYearView = FirstYearView);
    }
}

- (void)gotoToday
{
    [UIView animateWithDuration:0.5f animations:^{
        self.labOverToday.alpha = 0.8f;
    } completion:^(BOOL finished) {
        //修改当前的view 为本月
        yearView.calendar = [NSCalendar currentCalendar]; //NSChineseCalendar是农历。。。
        yearView.calendarDate = [NSDate date];
        yearView.components = [yearView.calendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:yearView.calendarDate];
        for (id item in yearView.subviews) {
            [CommonTool removeAllSubviews:item];
        }
        [yearView setNeedsDisplay];
        [UIView animateWithDuration:0.5f animations:^{
            ViewController *viewController = (ViewController *)[CommonTool findNearestViewController:self];
            [viewController setMonthNameLabel:self.labOverToday.text];
            self.labOverToday.alpha = 0.0f;
            yearView.yearLabel.alpha = 0.0f;
        }];
    }];
}

@end
