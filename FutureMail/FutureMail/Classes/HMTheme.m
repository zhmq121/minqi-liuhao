//
//  HMTheme.m
//  FutureMail
//
//  Created by Hao Liu on 12/22/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "HMTheme.h"

@implementation HMTheme

+ (void)styleDefaultAppApperance
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearanceWhenContainedIn:[UINavigationController class], nil];
    [navigationBarAppearance setBackgroundImage:[HMTheme navigationBackground] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:@{
                                                      NSFontAttributeName: [UIFont lightHMFontOfSize:18],
                                                      NSForegroundColorAttributeName: [UIColor whiteColor],
                                                      }];
    
    UIBarButtonItem *barButtonItemAppearance = [UIBarButtonItem appearance];
    
    [barButtonItemAppearance setTintColor:[UIColor whiteColor]];
    
    [barButtonItemAppearance setTitleTextAttributes:@{
                                                      NSFontAttributeName: [UIFont lightHMFontOfSize:16],
                                                      NSForegroundColorAttributeName: [UIColor whiteColor],
                                                      } forState:UIControlStateNormal];
    
    [barButtonItemAppearance setTitleTextAttributes:@{
                                                      NSFontAttributeName: [UIFont lightHMFontOfSize:16],
                                                      NSForegroundColorAttributeName: [UIColor whiteColor],
                                                      } forState:UIControlStateHighlighted];
}

+ (UIImage *)backButtonBackgroundImageForState:(UIControlState)state
{
    return [UIImage imageWithFrame:CGRectMake(0, 0, 34, 26) withColor:[UIColor clearColor]];
}

+ (UIImage *)navigationBackground
{
    return [UIImage imageWithColor:[UIColor HMLoungeBuddyColor]];
}

+ (UIImage *)borderedButtonBackgroundImageForState:(UIControlState)state
{
    return [UIImage imageWithFrame:CGRectMake(0, 0, 34, 26) withColor:[UIColor clearColor]];
}

@end
