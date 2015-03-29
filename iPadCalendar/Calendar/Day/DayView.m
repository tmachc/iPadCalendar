//
//  DayView.m
//  InTraining
//
//  Created by tmachc on 14-9-22.
//  Copyright (c) 2014年 crab. All rights reserved.
//

#import "DayView.h"

@implementation DayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UILabel *)dayLabel
{
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 524 - 29.0f)];
        _dayLabel.font = [UIFont boldSystemFontOfSize:40.0f];
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        _dayLabel.alpha = 0.8f;
        _dayLabel.backgroundColor = [UIColor whiteColor];
    }
    return _dayLabel;
}

- (UIImageView *)imgBg
{
    if (!_imgBg) {
        
        _imgBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _imgBg.image = ImageNamed(@"img_Daybg.png");
        _imgBg.backgroundColor = RGBCOLOR(243, 243, 243);
    }
    return _imgBg;
}

- (void)drawRect:(CGRect)rect
{
    //添加背景图片
    [self addSubview:self.imgBg];
    [self addSubview:self.dayLabel];
    // 拿数据 铺数据
    [self addDayData];
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    _dayLabel = nil;
    _imgBg = nil;
}

- (void)addDayData
{
    
}

- (IBAction)clickToDetail:(id)sender
{
    
}

@end
