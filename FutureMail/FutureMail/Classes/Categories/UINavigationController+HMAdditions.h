//
//  UINavigationController+HMAdditions.h
//  FutureMail
//
//  Created by Hao Liu on 12/22/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

@interface UINavigationController (HMAdditions)

// Speed up default IOS7 lagging animation
- (void)pushViewControllerWithTransparentBackground:(UIViewController *)viewController animated:(BOOL)animated;

@end
