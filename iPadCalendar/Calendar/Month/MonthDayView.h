//
//  MonthDayView.h
//  InTraining
//
//  Created by tmachc on 14-9-15.
//  Copyright (c) 2014年 crab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonthDayView : UIView

@property (nonatomic,assign) float height;
@property (nonatomic,strong) NSMutableDictionary *eventDic;

- (void)setDayNum:(int)num AndColor:(UIColor *)color AndAlpha:(float)alpha;
- (void)addEventWithAry:(NSArray *)ary AndNum:(int)num;
- (void)isToday;

@end
