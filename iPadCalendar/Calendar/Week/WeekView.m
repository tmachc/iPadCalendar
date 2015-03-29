//
//  WeekView.m
//  InTraining
//
//  Created by tmachc on 14-9-17.
//  Copyright (c) 2014年 crab. All rights reserved.
//

#import "WeekView.h"

@implementation WeekView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UILabel *)weekLabel
{
    if (!_weekLabel) {
        _weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 29.0f, self.frame.size.width, 524 - 29.0f)];
        _weekLabel.font = [UIFont boldSystemFontOfSize:40.0f];
        _weekLabel.textAlignment = NSTextAlignmentCenter;
        _weekLabel.alpha = 0.8f;
        _weekLabel.backgroundColor = [UIColor whiteColor];
        _weekLabel.text = _weekStr;
    }
    return _weekLabel;
}

- (UIImageView *)imgBg
{
    if (!_imgBg) {
        _imgBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _imgBg.image = ImageNamed(@"img_weekBg.png"); 
        _imgBg.backgroundColor = [UIColor clearColor];
    }
    return _imgBg;
}

- (UIImageView *)todayBg
{
    if (!_todayBg) {
        _todayBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 137, self.frame.size.height)];
        _todayBg.image = ImageNamed(@"img_weekTodayBg.png");
        _todayBg.hidden = YES;
    }
    return _todayBg;
}

- (void)drawRect:(CGRect)rect
{
    [self addSubview:self.imgBg];
    [self addSubview:self.todayBg];
    [self addSubview:self.weekLabel];
    
    // 拿数据 铺数据
    [self addWeekData];
}

- (void)setWeekNameLabel:(UILabel *)label i:(int)i
{
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:15.0f];
    label.tag = i + 200;
    label.backgroundColor = [UIColor clearColor];
    if (i == 0 || i == 6) {
        label.textColor = RGBCOLOR(153.0f, 153.0f, 153.0f);
    } else {
        label.textColor = [UIColor whiteColor];
    }
}

- (void)addTodayBg:(float)x
{
    self.todayBg.hidden = NO;
    CGRect rect = _todayBg.frame;
    rect.origin.x = x;
    _todayBg.frame = rect;
}

- (void)hideTodayBg
{
    self.todayBg.hidden = YES;
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    _imgBg = nil;
    _todayBg = nil;
    _weekLabel = nil;
    _weekStr = nil;
}

- (void)addWeekData
{
    
}

- (void)setWeekDateWithDic:(NSDictionary *)dic comps:(NSDateComponents *)comps i:(int)i
{
    
}

- (IBAction)clickToDetail:(id)sender
{
    
}

@end
