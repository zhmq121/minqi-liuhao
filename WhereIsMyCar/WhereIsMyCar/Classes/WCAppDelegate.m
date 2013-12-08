//
//  WCAppDelegate.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 8/26/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCAppDelegate.h"
#import "WCTheme.h"
#import "WCFavoritesManager.h"
#import "WCConfigManager.h"
#import "WCViewController.h"

@implementation WCAppDelegate

+ (WCAppDelegate *)appDelegate
{
    return (WCAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [WCTheme styleDefaultAppApperance];
    
    [self setupMainMenuWithAnimation:NO];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[WCFavoritesManager sharedInstance] saveFavoritesToDisk];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    
}

- (void)setCenterController:(UIViewController *)controller
{
    [self pushViewController:controller animated:YES];
}

- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated
{
    if ([controller isKindOfClass:[WCViewController class]] && ((WCViewController *)controller).hasTransparentBackground)
    {
        [self.navigationController pushViewControllerWithTransparentBackground:controller animated:animated];
    }
    else
    {
        [self.navigationController pushViewController:controller animated:animated];
    }
}

/*
- (void)setupDrawerWithAnimation:(BOOL)animated
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.menuController = [[WCMainMenuViewController alloc] init];
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:[[UINavigationController alloc] init] leftDrawerViewController:self.menuController];
    
    self.drawerController.showsShadow = NO;
    self.drawerController.showsStatusBarBackgroundView = YES;
    self.drawerController.statusBarViewBackgroundColor = [UIColor clearColor];
    self.drawerController.maximumLeftDrawerWidth = self.window.bounds.size.width;
    
    [self.drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        if (drawerSide == MMDrawerSideLeft)
            drawerController.leftDrawerViewController.view.frameRight = drawerController.maximumLeftDrawerWidth * percentVisible;
    }];
    
    [self.drawerController openDrawerSide:MMDrawerSideLeft animated:NO completion:nil];
    self.window.rootViewController = self.drawerController;
    
    [self.window makeKeyAndVisible];
    
    // animation goes here
}
 */

- (void)setupMainMenuWithAnimation:(BOOL)animated
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];

    self.menuController = [[WCMainMenuViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.menuController];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
}

- (void)popToMenu
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if (application.applicationState == UIApplicationStateActive)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alarm", @"")
                                                            message:notification.alertBody
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}

@end
