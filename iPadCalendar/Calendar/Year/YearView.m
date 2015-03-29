//
//  YearView.m
//  InTraining
//
//  Created by tmachc on 14-9-19.
//  Copyright (c) 2014年 crab. All rights reserved.
//

#import "YearView.h"

@implementation YearView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UILabel *)yearLabel
{
    if (!_yearLabel) {
        _yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _yearLabel.font = [UIFont boldSystemFontOfSize:40.0f];
        _yearLabel.textAlignment = NSTextAlignmentCenter;
        _yearLabel.alpha = 0.8f;
        _yearLabel.backgroundColor = [UIColor clearColor];
    }
    return _yearLabel;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat width = rect.size.width / 4;
    CGFloat height = (rect.size.height - 8) / 3; // 有8像素的进度条
    _weekName = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    
    // 时间调到今年的1月1号
    _components = [self.calendar components:(NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:_calendarDate];
    _components.month = 1;
    _components.day = 1;
    NSDate *currentCalendarDate = [self.calendar dateFromComponents:_components];
    NSRange days = [self.calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:currentCalendarDate];
    NSInteger monthLength = days.length;   //一个月有多少天
    NSInteger weekday = [_components weekday];
    weekday  = weekday - 1;  //默认是周六开始 -1为周日开始 weekday表示1号前面有weekday个空位置
    if(weekday < 0) {
        weekday += 7;
    }
    
    // 添加12个月的view
    for (int j = 0; j < 12; j ++) {
        // 添加每个月的button button下添加view
        UIButton *monthForYearBtn = [[UIButton alloc] initWithFrame:CGRectMake((j % 4) * width, (j / 4) * height, width, height)];
//        monthForYearBtn.layer.borderWidth = 0.5f;
        [monthForYearBtn addTarget:self action:@selector(gotoMonthCalendar:) forControlEvents:UIControlEventTouchUpInside];
        monthForYearBtn.tag = j + 300;
        monthForYearBtn.backgroundColor = [UIColor whiteColor];
        [self addSubview:monthForYearBtn];
        
        // 添加月份
        UILabel *monthNameLab = [[UILabel alloc] initWithFrame:CGRectMake(23, 24, 45, 24)];
        monthNameLab.text = [NSString stringWithFormat:@"%d月",(int)_components.month];
        monthNameLab.textAlignment = NSTextAlignmentRight;
        monthNameLab.textColor = RGBCOLOR(0, 163, 272);
        monthNameLab.font = [UIFont boldSystemFontOfSize:20.0f];
        [monthForYearBtn addSubview:monthNameLab];
        monthNameLab = nil;
        
        // 添加_weekName
        UILabel *weekNameLab = [[UILabel alloc] initWithFrame:CGRectMake(73, 24, 160, 19)];
        weekNameLab.text = _weekName[0];
        for (int i=1; i<7; i++) {
            weekNameLab.text = [NSString stringWithFormat:@"%@    %@",weekNameLab.text,_weekName[i]];
        }
        weekNameLab.textAlignment = NSTextAlignmentCenter;
        weekNameLab.textColor = [UIColor grayColor];
        weekNameLab.font = [UIFont boldSystemFontOfSize:11.0f];
        weekNameLab.backgroundColor = [UIColor clearColor];
        [monthForYearBtn addSubview:weekNameLab];
        weekNameLab = nil;
        
        // 添加日期
        for (int i = 1; i <= (int)monthLength; i++) {
            NSInteger offsetX = (24 * ((i + weekday - 1) % 7));
            NSInteger offsetY = (20 * ((i + weekday - 1) / 7));
            
            UILabel *dayForMonthLab = [[UILabel alloc] initWithFrame:CGRectMake(70 + offsetX, 44 + offsetY, 22, 18)];
            dayForMonthLab.layer.cornerRadius = 5.0f;
            dayForMonthLab.opaque = NO;
            dayForMonthLab.layer.masksToBounds = YES;
            dayForMonthLab.text = [NSString stringWithFormat:@"%d",i];
            dayForMonthLab.textAlignment = NSTextAlignmentCenter;
            dayForMonthLab.textColor = [UIColor blackColor];
            dayForMonthLab.font = [UIFont boldSystemFontOfSize:11.0f];
//            dayForMonthLab.backgroundColor = RGBCOLOR(189, 228, 242);
            dayForMonthLab.backgroundColor = [UIColor clearColor];
            dayForMonthLab.tag = j * 1000 + i;
            [monthForYearBtn addSubview:dayForMonthLab];
            dayForMonthLab = nil;
        }
        
        // 日历换到下一个月
        _components.month ++;
        currentCalendarDate = [self.calendar dateFromComponents:_components];
        _components = [self.calendar components:(NSEraCalendarUnit | NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:currentCalendarDate];
        days = [self.calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:currentCalendarDate];
        monthLength = days.length;   //一个月有多少天
        weekday = [_components weekday];
        weekday  = weekday - 1;  //默认是周六开始 -1为周日开始 weekday表示1号前面有weekday个空位置
        if(weekday < 0) {
            weekday += 7;
        }
        
        monthForYearBtn = nil;
    }
    
    _overBgimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    _overBgimg.image = ImageNamed(@"yearOverBg.jpg");
    _overBgimg.alpha = 0.0f;
    [self addSubview:_overBgimg];
    	
    // 添加滑动的遮罩
    [self addSubview:self.yearLabel];
    _yearLabel.text = [NSString stringWithFormat:@"%d 年",(int)_components.year - 1];
    
    // 添加数据
    [self addYearData];
}

- (void)addYearData
{
    [(UILabel *)self viewWithTag:8012].backgroundColor = RGBCOLOR(189, 228, 242);
    [(UILabel *)self viewWithTag:8013].backgroundColor = RGBCOLOR(189, 228, 242);
    [(UILabel *)self viewWithTag:10003].backgroundColor = RGBCOLOR(189, 228, 242);
    [(UILabel *)self viewWithTag:1001].backgroundColor = RGBCOLOR(189, 228, 242);
}

- (IBAction)gotoMonthCalendar:(id)sender
{
    ViewController *viewController = (ViewController *)[CommonTool findNearestViewController:self];
    [viewController gotoMonthCalendar:(int)[sender tag] - 300 + 1];
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    _calendar = nil;
    _components = nil;
    _calendarDate = nil;
    _yearLabel = nil;
    _viewSummary = nil;
    _labPercent = nil;
    _lab2 = nil;
}

@end
