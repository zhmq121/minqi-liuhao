
//
//  WCTheme.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 9/8/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCTheme.h"

@implementation WCTheme

+ (void)styleDefaultAppApperance
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearanceWhenContainedIn:[UINavigationController class], nil];
    [navigationBarAppearance setBackgroundImage:[WCTheme navigationBackground] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:@{
                                                      NSFontAttributeName: [UIFont lightWCFontOfSize:18],
                                                      NSForegroundColorAttributeName: [UIColor whiteColor],
     }];

    UIBarButtonItem *barButtonItemAppearance = [UIBarButtonItem appearance];
    
    [barButtonItemAppearance setTintColor:[UIColor whiteColor]];
    
    [barButtonItemAppearance setTitleTextAttributes:@{
                                                      NSFontAttributeName: [UIFont lightWCFontOfSize:16],
                                                      NSForegroundColorAttributeName: [UIColor whiteColor],
     } forState:UIControlStateNormal];
    
    [barButtonItemAppearance setTitleTextAttributes:@{
                                                      NSFontAttributeName: [UIFont lightWCFontOfSize:16],
                                                      NSForegroundColorAttributeName: [UIColor whiteColor],
     } forState:UIControlStateHighlighted];
}

+ (UIImage *)backButtonBackgroundImageForState:(UIControlState)state
{
    return [UIImage imageWithFrame:CGRectMake(0, 0, 34, 26) withColor:[UIColor clearColor]];
}
     
+ (UIImage *)navigationBackground
{
    return [UIImage imageWithColor:[UIColor WCLoungeBuddyColor]];
}

+ (UIImage *)borderedButtonBackgroundImageForState:(UIControlState)state
{
    return [UIImage imageWithFrame:CGRectMake(0, 0, 34, 26) withColor:[UIColor clearColor]];
}


@end
