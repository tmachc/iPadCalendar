//
//  CommonTool.h
//  eAinng
//
//  Created by tmachc on 14-9-18.
//  Copyright (c) 2014年 crab. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RGBCOLOR(r,g,b)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]         //RGB进制颜色值
#define ResourcePath     [[NSBundle mainBundle] resourcePath]    //获取自定义文件的bundle路径
#define ImageNamed(name) [UIImage imageWithContentsOfFile:[ResourcePath stringByAppendingPathComponent:name]]
#define SystemVersion [[[UIDevice currentDevice] systemVersion] floatValue] // 系统当前版本

typedef enum {
    FirstWeekNameView = 700,
    SecondWeekNameView
} StateWeekNameView;

@interface CommonTool : NSObject

// 移除所有子view
+ (void)removeAllSubviews:(id)view;
//找到最近的上一级 ViewController
+ (UIViewController *)findNearestViewController:(UIView *)view;

@end
