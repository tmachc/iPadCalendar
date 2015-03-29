//
//  CommonTool.m
//  eAinng
//
//  Created by tmachc on 14-9-18.
//  Copyright (c) 2014年 crab. All rights reserved.
//

#import "CommonTool.h"
#import "AppDelegate.h"

#import <CommonCrypto/CommonDigest.h>

@implementation CommonTool

// 移除所有子view
+ (void)removeAllSubviews:(id)view
{
    for (id subview in [view subviews]) {
        if ([subview isKindOfClass:[UIView class]] || [subview isKindOfClass:[UILabel class]] || [subview isKindOfClass:[UIButton class]]) {
            if ([subview subviews].count != 0) {
                [CommonTool removeAllSubviews:subview];
            }
        }
        [subview removeFromSuperview];
    }
    [view removeFromSuperview];
}
//找到最近的上一级 ViewController
+ (UIViewController *)findNearestViewController:(UIView *)view
{
	UIViewController *viewController = nil;
	for (UIView *next = [view superview]; next; next = next.superview) {
		UIResponder *nextResponder = [next nextResponder];
		if ([nextResponder isKindOfClass:[UIViewController class]]) {
			viewController = (UIViewController *)nextResponder;
			break;
		}
	}
	return viewController;
}

@end
