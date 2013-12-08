//
//  WCGlassGreenButton.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 8/28/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCGlassGreenButton.h"

@implementation WCGlassGreenButton

- (void)willMoveToSuperview:(UIView *)newSuperview
{
//    [self setBackgroundImage:[UIImage imageWithColor:[UIColor WCGreenColorR80G156B90Alpha0_8]] forState:UIControlStateNormal];
//    [self setBackgroundImage:[UIImage imageWithColor:[UIColor WCGreenColorR80G156B90Alpha0_8]] forState:UIControlStateHighlighted];
//    
    [self setTitleColorForAllStates:[UIColor whiteColor]];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self setTitleForAllStates:title];
}

@end
