//
//  UINavigationController+HMAdditions.m
//  FutureMail
//
//  Created by Hao Liu on 12/22/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "UINavigationController+HMAdditions.h"

@implementation UINavigationController (HMAdditions)

- (void)pushViewControllerWithTransparentBackground:(UIViewController *)viewController animated:(BOOL)animated
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(7.0))
    {
        if (animated)
        {
            CATransition *transition = [CATransition animation];
            transition.duration = 0.25;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromRight;
            [self.view.layer addAnimation:transition forKey:nil];
        }
        
        [self pushViewController:viewController animated:NO];
    }
    else
    {
        [self pushViewController:viewController animated:animated];
    }
}

@end
