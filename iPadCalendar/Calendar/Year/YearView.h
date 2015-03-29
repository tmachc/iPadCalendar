//
//  YearView.h
//  InTraining
//
//  Created by tmachc on 14-9-19.
//  Copyright (c) 2014年 crab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YearView : UIView {
    NSArray *_weekName;
}

@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSDateComponents *components;
@property (nonatomic, strong) NSDate *calendarDate;
@property (nonatomic, assign) NSInteger todayMonth;
@property (nonatomic, assign) NSInteger todayYear;
@property (nonatomic, assign) NSInteger todayDate;

@property (nonatomic, strong) UIImageView *overBgimg;
@property (nonatomic, strong) UILabel *yearLabel;
@property (nonatomic, strong) UIView *viewFooter;
@property (nonatomic, strong) UIView *viewSummary;
@property (nonatomic, strong) UILabel *labPercent;
@property (nonatomic, strong) UILabel *lab2;

- (void)addYearData;

@end
