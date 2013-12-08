//
//  WCMainMenuButton.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 8/26/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCMainMenuButton.h"


@implementation WCMainMenuButton

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor WCBlackColorR36G37B42Alpha0_5]] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor WCGrayColorR72G74B82]] forState:UIControlStateHighlighted];
    
    [self setTitleColorForAllStates:[UIColor whiteColor]];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self setTitleForAllStates:title];
}

@end
