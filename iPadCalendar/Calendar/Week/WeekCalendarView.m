//
//  WeekCalendarView.m
//  InTraining
//
//  Created by tmachc on 14-9-17.
//  Copyright (c) 2014年 crab. All rights reserved.
//

#import "WeekCalendarView.h"

@implementation WeekCalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark - 延迟实例化

- (UIView *)weekNameView
{
    if (!_weekNameView) {
        _weekNameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 29)];
        _weekNameView.backgroundColor = [UIColor clearColor];
        _weekNameView.tag = FirstWeekNameView;
    }
    return _weekNameView;
}
- (UIView *)nextWeekNameView
{
    if (!_nextWeekNameView) {
        _nextWeekNameView = [[UIView alloc] initWithFrame:CGRectMake(1024, 0, 1024, 29)];
        _nextWeekNameView.backgroundColor = [UIColor clearColor];
        _nextWeekNameView.tag = SecondWeekNameView;
    }
    return _nextWeekNameView;
}
- (UILabel *)labOverToday
{
    if (!_labOverToday) {
        _labOverToday = [[UILabel alloc] initWithFrame:CGRectMake(65, 29, 1024 - 65, 524 - 29)];
        _labOverToday.font = [UIFont boldSystemFontOfSize:40.0f];
        _labOverToday.textAlignment = NSTextAlignmentCenter;
        _labOverToday.alpha = 0.0f;
        _labOverToday.backgroundColor = [UIColor whiteColor];
    }
    return _labOverToday;
}

- (UIView *)viewTodayTime
{
    if (!_viewTodayTime) {
        _viewTodayTime = [[UIView alloc] initWithFrame:CGRectMake(21.0f, 0, self.frame.size.width - 21.0f, 15.0f)];
        _viewTodayTime.backgroundColor = [UIColor clearColor];
        UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 47, 15)];
        bg.image = ImageNamed(@"calendar_time.png");
        [_viewTodayTime addSubview:bg];
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(47, 7, _viewTodayTime.frame.size.width - 47, 1)];
        line.backgroundColor = RGBCOLOR(14, 172, 238);
        [_viewTodayTime addSubview:line];
    }
    return _viewTodayTime;
}

- (UILabel *)labelTime
{
    if (!_labelTime) {
        _labelTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 38, 15)];
        _labelTime.font = [UIFont boldSystemFontOfSize:12.0f];
        _labelTime.textAlignment = NSTextAlignmentCenter;
        _labelTime.textColor = [UIColor whiteColor];
        _labelTime.backgroundColor = [UIColor clearColor];
    }
    return _labelTime;
}

- (UIImageView *)todayState
{
    if (!_todayState) {
        _todayState = [[UIImageView alloc] initWithFrame:CGRectMake(((int)self.components.weekday - 1) * 137, 29, 137, 5)];
        _todayState.backgroundColor = RGBCOLOR(14, 172, 238);
        [self addSubview:_todayState];
    }
    return _todayState;
}

#pragma mark - view

- (void)drawRect:(CGRect)rect
{
    
    // 添加weeknameview
    // 添加weeknameview
    [self addSubview:self.weekNameView];
    _currentWeekNameView = FirstWeekNameView;
    [self setWeekName:_weekNameView];
    [self addSubview:self.nextWeekNameView];
    
    //添加背景
    _scrBg = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 29, 1024, 495)];
    _scrBg.contentSize = CGSizeMake(1024, 50.5 * 24);
    _scrBg.contentOffset = CGPointMake(0, 50.5 * 7);
    _scrBg.backgroundColor = [UIColor clearColor];
    [self addSubview:_scrBg];
    contentWidth = _scrBg.contentSize.width;
    contentHeight = _scrBg.contentSize.height;
        // 左侧的时间
        _imgTime = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, contentHeight)];
        _imgTime.image = ImageNamed(@"img_weektime.png");
        [_scrBg addSubview:_imgTime];
        
        // 内容
        _viewContent = [[UIView alloc] initWithFrame:CGRectMake(65, 0, contentWidth - 65, contentHeight)];
        _viewContent.backgroundColor = [UIColor clearColor];
        [_viewContent setClipsToBounds:YES];  //剪裁超出父视图范围的子视图部分
        [_scrBg addSubview:_viewContent];
        
            //当前的周历
            weekView = [[WeekView alloc]initWithFrame:CGRectMake(0, 0, contentWidth - 65, contentHeight)];
            weekView.components = self.components;
            weekView.tag = FirstWeekView;
            _currentWeekView = FirstWeekView;
            weekView.weekLabel.text = weekStr;
            weekView.backgroundColor = [UIColor clearColor];
            [_viewContent addSubview:weekView];
            
            UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
            swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
            UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
            swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
            [weekView addGestureRecognizer:swipeLeft];
            [weekView addGestureRecognizer:swipeRight];
            
            //上一周的
            leftWeekView = [[WeekView alloc]initWithFrame:CGRectMake(contentWidth - 65, 0, contentWidth - 65, contentHeight)];
            leftWeekView.components = self.components;
            leftWeekView.tag = SecondWeekView;
            leftWeekView.backgroundColor = [UIColor clearColor];
            [_viewContent addSubview:leftWeekView];
    
    // 如果本周含有今天
    if ([self judgeTodayOnWeek:self.components]) {
        [self addTodayTime];
        [weekView addTodayBg: ((int)self.components.weekday - 1) * 137];
        
        self.todayState.frame = CGRectMake(((int)self.components.weekday - 1) * 137 + 65, 29, 137, 5);
    }
    
    ViewController *viewController = (ViewController *)[CommonTool findNearestViewController:self];
    [viewController setMonthNameLabel:weekStr];
    //添加遮罩
    [self addSubview:self.labOverToday];
    self.labOverToday.text = [self todayWeekStr];
    
    weekView.weekLabel.alpha = 0.0f;
}

#pragma mark - function

- (void)addTodayTime
{
    [CommonTool removeAllSubviews:_viewTodayTime];
    _viewTodayTime = nil;
    //添加当前时间
    [_scrBg addSubview:self.viewTodayTime];
    CGRect viewTodayTimeRect = self.viewTodayTime.frame;
    viewTodayTimeRect.origin.y = ((float)_components.hour + (float)_components.minute / 60.0 - 1) * 50.5 - viewTodayTimeRect.size.height/2;
    self.viewTodayTime.frame = viewTodayTimeRect;
    [_viewTodayTime addSubview:self.labelTime];
    (int)_components.minute < 10 ? (self.labelTime.text = [NSString stringWithFormat:@"%d:0%d",(int)_components.hour,(int)_components.minute]) : (self.labelTime.text = [NSString stringWithFormat:@"%d:%d",(int)_components.hour,(int)_components.minute]);
}

- (void)setWeekName:(UIView *)view
{
    for (id item in view.subviews) {
        [CommonTool removeAllSubviews:item];
    }
    CGFloat height = 29.0f;
    CGFloat width = 137.0f;
    CGFloat extra = 24.0f;
    _weekNames = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    
    //添加上面的日期
    NSDateComponents *comps = [self.calendar components:(NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:_calendarDate];
    weekday = [comps weekday];
    
    NSRange days = [self.calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self.calendarDate];
    NSInteger monthLength = days.length;   //一个月有多少天
    
    weekday = weekday - 1;  //默认是周六开始 -1为周日开始 weekday表示1号前面有weekday个空位置
    if(weekday < 0) {
        weekday += 7;
    }
    
    if (((int)comps.day - (int)weekday) <= 0) {
        //包含上个月的内容
        NSDateComponents *previousMonthComponents = [self.calendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self.calendarDate];
        previousMonthComponents.month -= 1;
        NSDate *previousMonthDate = [self.calendar dateFromComponents:previousMonthComponents];
        previousMonthComponents = [self.calendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:previousMonthDate];
        NSRange previousMonthDays = [self.calendar rangeOfUnit:NSDayCalendarUnit
                                                        inUnit:NSMonthCalendarUnit
                                                       forDate:previousMonthDate];
        NSInteger maxDate = previousMonthDays.length - weekday + 1;
        
        //添加上个月的要显示的
        for (int i = 0; i < (int)weekday; i ++) {
            UILabel *weekNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65 + i * width + extra/2, 0, width - extra, height)];
            [self setWeekNameLabel:weekNameLabel i:i];
            weekNameLabel.text = [NSString stringWithFormat:@"%@ %d月%d日", _weekNames[i] ,((int)comps.month == 1 ? 12 : (int)comps.month - 1), (int)maxDate + i];
            [view addSubview:weekNameLabel];
            
            if (i == 0) {
                weekStr = [NSString stringWithFormat:@"%d年，%d月%d日-",(int)previousMonthComponents.year,(int)previousMonthComponents.month,(int)maxDate + i];
            }
        }
        
        //添加这个月的
        for (int i = (int)weekday; i < 7; i ++) {
            UILabel *weekNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65 + i * width + extra/2, 0, width - extra, height)];
            [self setWeekNameLabel:weekNameLabel i:i];
            weekNameLabel.text = [NSString stringWithFormat:@"%@ %d月%d日", _weekNames[i] ,(int)comps.month, i - (int)weekday + 1];
            [view addSubview:weekNameLabel];
            
            if (i == 6) {
                weekStr = [NSString stringWithFormat:@"%@%d月%d日",weekStr,(int)comps.month,i - (int)weekday + 1];
            }
        }
        
    } else if (((int)monthLength - (int)comps.day + (int)weekday) < 6) { //这个月还剩几天，加上前面空的位置数，小于6
        //包含下个月的内容
        //先添加这个月的
        int leftNum = (int)monthLength - (int)comps.day + 1 + (int)weekday;
        for (int i = 0; i < leftNum; i ++) {
            UILabel *weekNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65 + i * width + extra/2, 0, width - extra, height)];
            [self setWeekNameLabel:weekNameLabel i:i];
            weekNameLabel.text = [NSString stringWithFormat:@"%@ %d月%d日", _weekNames[i] ,(int)comps.month, (int)monthLength - leftNum + 1 + i];
            [view addSubview:weekNameLabel];
            
            if (i == 0) {
                weekStr = [NSString stringWithFormat:@"%d年，%d月%d日-",(int)comps.year,(int)comps.month,(int)monthLength - leftNum + 1 + i];
            }
        }
        //再添加下个月的
        for (int i = leftNum; i < 7; i ++) {
            UILabel *weekNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65 + i * width + extra/2, 0, width - extra, height)];
            [self setWeekNameLabel:weekNameLabel i:i];
            weekNameLabel.text = [NSString stringWithFormat:@"%@ %d月%d日", _weekNames[i] ,((int)comps.month == 12 ? 1 : (int)comps.month + 1), i - leftNum + 1];
            [view addSubview:weekNameLabel];
            
            if (i == 6) {
                weekStr = [NSString stringWithFormat:@"%@%d月%d日",weekStr,((int)comps.month == 12 ? 1 : (int)comps.month + 1),i - leftNum + 1];
            }
        }
    } else {
        //只包含当月的内容
        for (int i = 0; i < 7; i ++) {
            UILabel *weekNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65 + i * width + extra/2, 0, width - extra, height)];
            [self setWeekNameLabel:weekNameLabel i:i];
            weekNameLabel.text = [NSString stringWithFormat:@"%@ %d月%d日", _weekNames[i] ,(int)comps.month, (int)comps.day - (int)weekday + i];
            [view addSubview:weekNameLabel];
            
            if (i == 0) {
                weekStr = [NSString stringWithFormat:@"%d年，%d月%d日-",(int)comps.year,(int)comps.month,(int)comps.day - (int)weekday + i];
            }
            
            if (i == 6) {
                weekStr = [NSString stringWithFormat:@"%@%d日",weekStr,(int)comps.day - (int)weekday + i];
            }
        }
    }
    
    if ([self judgeTodayOnWeek:comps]) {
        //修改当天的日期字体颜色
        if ((int)view.tag == FirstWeekNameView || (int)view.tag == SecondWeekNameView) {
            UILabel *todayLab = (UILabel *)[self viewWithTag:comps.weekday - 1 + 200];
            todayLab = (UILabel *)[self viewWithTag:weekday + 200];
            todayLab.textColor = RGBCOLOR(14, 172, 238);
        }
    }
}

- (void)setWeekNameLabel:(UILabel *)label i:(int)i
{
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:15.0f];
    label.tag = i + 200;
    label.backgroundColor = [UIColor clearColor];
    label.layer.cornerRadius = 5.0f;
    label.opaque = NO;
    label.layer.masksToBounds = YES;
    if (i == 0 || i == 6) {
        label.textColor = RGBCOLOR(153.0f, 153.0f, 153.0f);
    } else {
        label.textColor = [UIColor whiteColor];
    }
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    _calendar = nil;
    _components = nil;
    _calendarDate = nil;
    _labOverToday = nil;
    weekView = nil;
    leftWeekView = nil;
    _scrBg = nil;
    _todayState = nil;
    _viewTodayTime = nil;
    _labelTime = nil;
    _viewContent = nil;
    _imgTime = nil;
    _weekNameView = nil;
    _nextWeekNameView = nil;
}

- (void)gotoToday
{
    [UIView animateWithDuration:0.5f animations:^{
        self.labOverToday.alpha = 0.8f;
    } completion:^(BOOL finished) {
        //修改当前的view 为本月
        WeekView *view = (WeekView *)[self viewWithTag:_currentWeekView];
        UIView *weekName = (UIView *)[self viewWithTag:_currentWeekNameView];
        self.calendar = [NSCalendar currentCalendar]; //NSChineseCalendar是农历。。。
        self.calendarDate = [NSDate date];
        self.components = [self.calendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:self.calendarDate];
        self.todayState.frame = CGRectMake(((int)self.components.weekday - 1) * 137 + 65, 29, 137, 5);
        for (id item in view.subviews) {
            [CommonTool removeAllSubviews:item];
        }
        [view setNeedsDisplay];
        [self setWeekName:weekName];
        [self addTodayTime];
        [view addTodayBg: ((int)self.components.weekday - 1) * 137];
        [UIView animateWithDuration:0.5f animations:^{
            ViewController *viewController = (ViewController *)[CommonTool findNearestViewController:self];
            [viewController setMonthNameLabel:self.labOverToday.text];
            self.labOverToday.alpha = 0.0f;
            view.weekLabel.alpha = 0.0f;
        }];
    }];
}

- (void)addWeekData
{
    WeekView *view = (WeekView *)[self viewWithTag:_currentWeekView];
    [view addWeekData];
}

#pragma mark - swipe

- (void)swipe:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft || swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        
        // 显示出遮罩层
        
        // view1 为当前的月份， view2 为即将要显示的月份
        WeekView *view1 = (WeekView *)[self viewWithTag:_currentWeekView];
        view1.weekLabel.alpha = 0.8f;
        CGRect rect5 = view1.weekLabel.frame;
        rect5.origin.y = _scrBg.contentOffset.y;
        view1.weekLabel.frame = rect5;
        
        WeekView *view2 = (WeekView *)[self viewWithTag:(_currentWeekView == FirstWeekView ? SecondWeekView : FirstWeekView)];
        view2.weekLabel.alpha = 0.8f;
        CGRect rect6 = view2.weekLabel.frame;
        rect6.origin.y = _scrBg.contentOffset.y;
        view2.weekLabel.frame = rect6;
        
        // 设置view2
        view2.frame = CGRectMake((swipe.direction == UISwipeGestureRecognizerDirectionLeft ? contentWidth - 65 : -(contentWidth - 65)) , 0, view2.frame.size.width, view2.frame.size.height);
        
        for (id item in view2.subviews) {
            [CommonTool removeAllSubviews:item];
        }
        [view2 setNeedsDisplay];
        
        // 设置 week
        UIView *week1 = [self viewWithTag:_currentWeekNameView];
        UIView *week2 = [self viewWithTag:(_currentWeekNameView == FirstWeekNameView ? SecondWeekNameView : FirstWeekNameView)];
        
        week2.frame = CGRectMake((swipe.direction == UISwipeGestureRecognizerDirectionLeft ? 1024.0f : -1024.0f) , 0, week2.frame.size.width, week2.frame.size.height);
        // 修改一下时间
        self.calendarDate = [self.calendar dateFromComponents:_components];
        
        // 以view1为基础，修改view2的时间
        self.components = [self.calendar components:(NSEraCalendarUnit | NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit) fromDate:self.calendarDate];
        swipe.direction == UISwipeGestureRecognizerDirectionLeft ? (self.components.day += 7) : (self.components.day -= 7);
        
        
        if ([self judgeTodayOnWeek:self.components]) {
            self.components = [[NSCalendar currentCalendar] components:(NSEraCalendarUnit | NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit) fromDate:[NSDate date]];
        } else {
            if ((int)self.components.weekday != 1) {
                self.components.day -= ((int)self.components.weekday - 1);
            }
        }
        
        // 更新下view2的日期
        self.calendarDate = [self.calendar dateFromComponents:self.components];
        self.components = [self.calendar components:(NSEraCalendarUnit | NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit) fromDate:self.calendarDate];
        view2.components = self.components;
        
        for (id item in week2.subviews) {
            [CommonTool removeAllSubviews:item];
        }
        [self setWeekName:week2];
        
        if ([self judgeTodayOnWeek:self.components]) {
            [view2 addTodayBg: ((int)self.components.weekday - 1) * 137];
        } else {
            [view2 hideTodayBg];
            [CommonTool removeAllSubviews:_viewTodayTime];
            [CommonTool removeAllSubviews:_todayState];
            _todayState = nil;
        }
        view2.weekLabel.text = weekStr;
        
        // 移动view的动画
        [UIView animateWithDuration:0.5 animations:^{
            CGRect rect1 = view1.frame;
            CGRect rect2 = view2.frame;
            CGRect rect3 = week1.frame;
            CGRect rect4 = week2.frame;
            if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
                rect1.origin.x -= contentWidth - 65;
                rect2.origin.x -= contentWidth - 65;
                rect3.origin.x -= 1024.0f;
                rect4.origin.x -= 1024.0f;
            } else {
                rect1.origin.x += contentWidth - 65;
                rect2.origin.x += contentWidth - 65;
                rect3.origin.x += 1024.0f;
                rect4.origin.x += 1024.0f;
            }
            view1.frame = rect1;
            view2.frame = rect2;
            week1.frame = rect3;
            week2.frame = rect4;
        } completion:^(BOOL finished) {
            // view1 移除手势
            for (UISwipeGestureRecognizer *swip in view1.gestureRecognizers) {
                [view1 removeGestureRecognizer:swip];
            }
            
            ViewController *viewController = (ViewController *)[CommonTool findNearestViewController:self];
            [viewController setMonthNameLabel:weekStr];
            if ([self judgeTodayOnWeek:self.components]) {
                [self addTodayTime];
                self.todayState.frame = CGRectMake(((int)self.components.weekday - 1) * 137 + 65, 29, 137, 5);
                [viewController setCalendarYear:self.components.year Month:self.components.month Date:_todayDate];
            } else {
                [viewController setCalendarYear:self.components.year Month:self.components.month Date:self.components.day];
            }
            // view2 添加手势
            UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
            swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
            [view2 addGestureRecognizer:swipeleft];
            UISwipeGestureRecognizer * swipeRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
            swipeRight.direction=UISwipeGestureRecognizerDirectionRight;
            [view2 addGestureRecognizer:swipeRight];
            
            // 修改_currentMonthView的值为当前view的tag
            _currentWeekView == FirstWeekView ? (_currentWeekView = SecondWeekView) : (_currentWeekView = FirstWeekView);
            _currentWeekNameView == FirstWeekNameView ? (_currentWeekNameView = SecondWeekNameView) : (_currentWeekNameView = FirstWeekNameView);
            
            // 隐藏遮罩层
            view1.weekLabel.alpha = 0.0f;
            view2.weekLabel.alpha = 0.0f;
        }];
    }
}
// 判断本周是否含有今天
- (BOOL)judgeTodayOnWeek:(NSDateComponents *)comps
{
    BOOL value;
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    currentComps.year = comps.year;
    currentComps.month = comps.month;
    currentComps.day = comps.day;
    currentComps.weekday = comps.weekday;
    
    if ((int)currentComps.weekday != 1) {
        currentComps.day -= ((int)currentComps.weekday - 1);
        NSDate *date = [self.calendar dateFromComponents:currentComps];
        currentComps = [self.calendar components:(NSEraCalendarUnit | NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit) fromDate:date];
    }
    long int a = (int)currentComps.year * 10000 + (int)currentComps.month * 100 + (int)currentComps.day;
    currentComps.day += 6;
    NSDate *date = [self.calendar dateFromComponents:currentComps];
    currentComps = [self.calendar components:(NSEraCalendarUnit | NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit) fromDate:date];
    long int b = (int)currentComps.year * 10000 + (int)currentComps.month * 100 + (int)currentComps.day;
    long int today = (int)_todayYear * 10000 + (int)_todayMonth * 100 + (int)_todayDate;
    if (a <= today && today <= b) {
        value = true;
    } else {
        value = false;
    }
    currentComps = nil;
    date = nil;
    return value;
}

- (NSString *)todayWeekStr
{
    NSString *str;
    NSDate *currentDate = _calendarDate;
    _calendarDate = [NSDate date];
    UIView *view = [[UIView alloc] init];
    [self setWeekName:view];
    str = weekStr;
    _calendarDate = currentDate;
    currentDate = nil;
    view = nil;
    return str;
}

@end
