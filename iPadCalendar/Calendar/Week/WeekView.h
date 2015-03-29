//
//  WeekView.h
//  InTraining
//
//  Created by tmachc on 14-9-17.
//  Copyright (c) 2014年 crab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeekView : UIView {
//    BOOL haveAddData;
}

@property (nonatomic, strong) UIImageView *imgBg;
@property (nonatomic, strong) UIImageView *todayBg;
@property (nonatomic, strong) UILabel *weekLabel;
@property (nonatomic, strong) NSString *weekStr;
@property (nonatomic, strong) NSDateComponents *components;
@property (nonatomic, strong) NSMutableArray *dataAry;

- (void)addTodayBg:(float)x;
- (void)hideTodayBg;

- (void)addWeekData;

@end
