//
//  MonthDayView.m
//  InTraining
//
//  Created by tmachc on 14-9-15.
//  Copyright (c) 2014年 crab. All rights reserved.
//

#import "MonthDayView.h"

@implementation MonthDayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}


- (NSMutableDictionary *)eventDic
{
    if (!_eventDic) {
        _eventDic = [NSMutableDictionary dictionaryWithDictionary:@{}];
    }
    return _eventDic;
}

- (void)setDayNum:(int)num AndColor:(UIColor *)color AndAlpha:(float)alpha
{
    
    UIImageView *imgBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imgBg.backgroundColor = color;
    imgBg.alpha = alpha;
    [self addSubview:imgBg];
    [self sendSubviewToBack:imgBg];
    
    UILabel *dayNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 20, 5, 20, 13)];
    dayNumLabel.backgroundColor = [UIColor clearColor];
    dayNumLabel.text = [NSString stringWithFormat:@"%d",num];
    dayNumLabel.textColor = RGBCOLOR(105, 105, 105);
    dayNumLabel.font = [UIFont boldSystemFontOfSize:12];
    SystemVersion <= 6.0 ? (self.layer.borderWidth = 0.5f) : (self.layer.borderWidth = 0.25f);
    self.layer.borderColor = RGBCOLOR(205, 205, 205).CGColor;
    [self addSubview:dayNumLabel];
    self.backgroundColor = [UIColor clearColor];
    
}

- (void)addEventWithAry:(NSArray *)ary AndNum:(int)num
{
    NSLog(@"dic--->>>%@ ----- >> %d",ary,num);
}

- (void)isToday
{
    UIImageView *imgLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 2)];
    imgLine.backgroundColor = RGBCOLOR(14, 172, 238);
    [self addSubview:imgLine];
}

- (IBAction)clickEvent:(id)sender
{
    
}

- (IBAction)clickLeftEvent:(id)sender
{
    
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    _eventDic = nil;
}

@end
