//
//  HMAppDelegate.h
//  FutureMail
//
//  Created by Hao Liu on 12/22/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

@interface HMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong) UINavigationController *navigationController;

+ (HMAppDelegate *)appDelegate;

- (void)setCenterController:(UIViewController *)controller;
- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated;
- (void)popToMenu;

@end
