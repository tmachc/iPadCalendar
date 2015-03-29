//
//  ViewController.m
//  iPadCalendar
//
//  Created by 韩冲 on 14/12/21.
//  Copyright (c) 2014年 tmachc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    // 日期
    _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; //NSChineseCalendar是农历。。。
    _calendarDate = [NSDate date];
    _components = [_calendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:_calendarDate];
    
    _todayDate = _components.day;
    _todayMonth = _components.month;
    _todayYear = _components.year;
    _year = _components.year;
    
    [self.view addSubview:self.viewCalendarNavigation];
    [self.view addSubview:self.btnToday];
    [self selectCalendar:self.btnMonth];
}

#pragma mark - function

- (IBAction)selectCalendar:(id)sender
{
    self.btnToday.hidden = NO;
    if (stateCalendarBtn != [sender tag]) {
        for (UIButton *btn in aryBtn) {
            if ([btn isEqual:sender]) {
                btn.selected = true;
                btn.backgroundColor = [UIColor whiteColor];
            } else {
                btn.selected = false;
                btn.backgroundColor = [UIColor clearColor];
            }
        }
        
        UIView *from;
        UIView *to;
        switch (stateCalendarBtn) {
            case StateDayBtn:
                from = self.dayCalendarView;
                break;
            case StateWeekBtn:
                from = self.weekCalendarView;
                break;
            case StateMonthBtn:
                from = self.monthCalendarView;
                break;
            case StateYearBtn:
                from = self.yearCalendarView;
                break;
            
            default:
                break;
        }
        switch ((int)[sender tag]) {  // 点击的按钮 控制将要展示的view
            case StateDayBtn:
                to = self.dayCalendarView;
                break;
            case StateWeekBtn:
                to = self.weekCalendarView;
                break;
            case StateMonthBtn:
                to = self.monthCalendarView;
                break;
            case StateYearBtn:
                to = self.yearCalendarView;
                break;
            
            default:
                break;
        }
        [self changeCalendarAnimationFrom:from To:to];
        
        stateCalendarBtn = (int)[sender tag];
    }
}
- (void)changeCalendarAnimationFrom:(UIView *)from To:(UIView *)to
{
    [self.view addSubview:to];
    [(MonthCalendarView *)to setTodayDate: _todayDate];
    [(MonthCalendarView *)to setTodayMonth: _todayMonth];
    [(MonthCalendarView *)to setTodayYear: _todayYear];
    
    [(MonthCalendarView *)to setCalendar: _calendar];
    [(MonthCalendarView *)to setCalendarDate: _calendarDate];
    [(MonthCalendarView *)to setComponents: _components];
    [to setNeedsDisplay];
    [UIView animateWithDuration:0.3f animations:^{
        from.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f animations:^{
            to.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [CommonTool removeAllSubviews:from];
        }];
    }];
}

#pragma mark - delegate

- (void)setCalendarYear:(NSInteger)year Month:(NSInteger)month Date:(NSInteger)date
{
    _calendar = [NSCalendar currentCalendar];
    _components.day = date;
    _components.month = month;
    _components.year = year;
    _calendarDate = [_calendar dateFromComponents:_components];
    _components = [_calendar components:(NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:_calendarDate];
    
    NSLog(@"当前日期-->%d年 %d月  %d日  周%d",(int)_components.year,(int)_components.month,(int)_components.day,(int)_components.weekday - 1);
}

- (void)setMonthNameLabel:(NSString *)monthName
{
    self.labTodayMonth.text = monthName;
}

- (void)gotoMonthCalendar:(int)month
{
    _components.month = month;
    _calendarDate = [_calendar dateFromComponents:_components];
    _components = [_calendar components:(NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:_calendarDate];
    
    _btnMonth.selected = true;
    _btnMonth.backgroundColor = [UIColor whiteColor];
    UIView *from = self.yearCalendarView;
    UIView *to = self.monthCalendarView;
    [self changeCalendarAnimationFrom:from To:to];
    _btnYear.selected = false;
    _btnYear.backgroundColor = [UIColor clearColor];
    stateCalendarBtn = StateMonthBtn;
}

- (IBAction)gotoToday:(id)sender
{
    switch (stateCalendarBtn) {
        case StateDayBtn:
            [_dayCalendarView gotoToday];
            break;
        case StateWeekBtn:
            [_weekCalendarView gotoToday];
            break;
        case StateMonthBtn:
            [_monthCalendarView gotoToday];
            break;
        case StateYearBtn:
            [_yearCalendarView gotoToday];
            break;
            
        default:
            break;
    }
    
    _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; //NSChineseCalendar是农历。。。
    _calendarDate = [NSDate date];
    _components = [_calendar components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:_calendarDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 延迟实例化

- (MonthCalendarView *)monthCalendarView
{
    if (!_monthCalendarView) {
        _monthCalendarView = [[MonthCalendarView alloc] initWithFrame:CGRectMake(0, 130, 1024, 524)];
        _monthCalendarView.userInteractionEnabled = YES;
        _monthCalendarView.backgroundColor = [UIColor clearColor];
        _monthCalendarView.tag = StateMonthBtn + 150;
        _monthCalendarView.alpha = 0.0f;
    }
    return _monthCalendarView;
}

- (WeekCalendarView *)weekCalendarView
{
    if (!_weekCalendarView) {
        _weekCalendarView = [[WeekCalendarView alloc] initWithFrame:CGRectMake(0, 130, 1024, 524)];
        _weekCalendarView.userInteractionEnabled = YES;
        _weekCalendarView.backgroundColor = [UIColor clearColor];
        _weekCalendarView.tag = StateWeekBtn + 150;
        _weekCalendarView.alpha = 0.0f;
    }
    return _weekCalendarView;
}

- (YearCalendarView *)yearCalendarView
{
    if (!_yearCalendarView) {
        _yearCalendarView = [[YearCalendarView alloc] initWithFrame:CGRectMake(0, 130, 1024, 524)];
        _yearCalendarView.userInteractionEnabled = YES;
        _yearCalendarView.tag = StateYearBtn + 150;
        _yearCalendarView.alpha = 0.0f;
    }
    return _yearCalendarView;
}

- (DayCalendarView *)dayCalendarView
{
    if (!_dayCalendarView) {
        _dayCalendarView = [[DayCalendarView alloc] initWithFrame:CGRectMake(0, 130, 1024, 524)];
        _dayCalendarView.userInteractionEnabled = YES;
        _dayCalendarView.backgroundColor = [UIColor clearColor];
        _dayCalendarView.tag = StateDayBtn + 150;
        _dayCalendarView.alpha = 0.0f;
    }
    return _dayCalendarView;
}

- (UIView *)viewCalendarNavigation
{
    if (!_viewCalendarNavigation) {
        _viewCalendarNavigation = [[UIView alloc] initWithFrame:CGRectMake(0, 70, 1024, 45)];
        _viewCalendarNavigation.backgroundColor = [UIColor clearColor];
        [_viewCalendarNavigation addSubview:self.btnDay];
        [_viewCalendarNavigation addSubview:self.btnWeek];
        [_viewCalendarNavigation addSubview:self.btnMonth];
        [_viewCalendarNavigation addSubview:self.btnYear];
        aryBtn = @[_btnDay,_btnWeek,_btnMonth,_btnYear];
    }
    return _viewCalendarNavigation;
}
#pragma mark viewCalendarNavigation中的元素

- (UIButton *)btnDay
{
    if (!_btnDay) {
        _btnDay = [[UIButton alloc] initWithFrame:CGRectMake(400, 9, 52, 32)];
        _btnDay.tag = StateDayBtn;
        [self setButton:_btnDay WithStr:@"日"];
    }
    return _btnDay;
}
- (UIButton *)btnWeek
{
    if (!_btnWeek) {
        _btnWeek = [[UIButton alloc] initWithFrame:CGRectMake(460, 9, 52, 32)];
        _btnWeek.tag = StateWeekBtn;
        [self setButton:_btnWeek WithStr:@"周"];
    }
    return _btnWeek;
}
- (UIButton *)btnMonth
{
    if (!_btnMonth) {
        _btnMonth = [[UIButton alloc] initWithFrame:CGRectMake(520, 9, 52, 32)];
        _btnMonth.tag = StateMonthBtn;
        [self setButton:_btnMonth WithStr:@"月"];
    }
    return _btnMonth;
}
- (UIButton *)btnYear
{
    if (!_btnYear) {
        _btnYear = [[UIButton alloc] initWithFrame:CGRectMake(580, 9, 52, 32)];
        _btnYear.tag = StateYearBtn;
        [self setButton:_btnYear WithStr:@"年"];
    }
    return _btnYear;
}
- (void)setButton:(UIButton *)btn WithStr:(NSString *)str
{
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:18];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitle:str forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn setTitle:str forState:UIControlStateSelected];
    
    btn.layer.cornerRadius = 5.0f;
    btn.opaque = NO;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(selectCalendar:) forControlEvents:UIControlEventTouchUpInside];
}
- (UILabel *)labTodayMonth
{
    if (!_labTodayMonth) {
        _labTodayMonth = [[UILabel alloc] initWithFrame:CGRectMake(113, 9, 283, 30)];
        _labTodayMonth.backgroundColor = [UIColor clearColor];
        _labTodayMonth.font = [UIFont boldSystemFontOfSize:22];
        _labTodayMonth.textColor = [UIColor whiteColor];
    }
    return _labTodayMonth;
}
- (UIButton *)btnToday {
    if (!_btnToday) {
        _btnToday = [[UIButton alloc] initWithFrame:CGRectMake(964, 663, 45, 30)];
        [_btnToday setTitle:@"今天" forState:UIControlStateNormal];
        _btnToday.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Medium" size:20];
        [_btnToday addTarget:self action:@selector(gotoToday:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnToday;
}

@end
