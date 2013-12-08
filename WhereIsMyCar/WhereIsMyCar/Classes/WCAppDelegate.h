//
//  WCAppDelegate.h
//  WhereIsMyCar
//
//  Created by Hao Liu on 8/26/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCMainMenuViewController.h"

@interface WCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong) MMDrawerController *drawerController;
@property (strong) WCMainMenuViewController *menuController;
@property (strong) UINavigationController *navigationController;

+ (WCAppDelegate *)appDelegate;

- (void)setCenterController:(UIViewController *)controller;
- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated;
- (void)popToMenu;

@end
