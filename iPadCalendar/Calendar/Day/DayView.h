//
//  DayView.h
//  InTraining
//
//  Created by tmachc on 14-9-22.
//  Copyright (c) 2014年 crab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayView : UIView {
    NSArray *_timeNames;
    NSArray *_weekNames1;
}

@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UIImageView *imgBg;
@property (nonatomic, strong) NSString *strMonth,*strDay;
@property (nonatomic, strong) NSArray *dataAry;

- (void)addDayData;

@end
