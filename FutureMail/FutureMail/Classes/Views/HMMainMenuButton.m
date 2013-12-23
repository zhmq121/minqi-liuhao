//
//  HMMainMenuButton.m
//  FutureMail
//
//  Created by Hao Liu on 12/22/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "HMMainMenuButton.h"

@implementation HMMainMenuButton

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor HMLoungeBuddyColor]] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor HMStormCloudColor]] forState:UIControlStateHighlighted];
    
    [self setTitleColorForAllStates:[UIColor whiteColor]];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self setTitleForAllStates:title];
}

@end
