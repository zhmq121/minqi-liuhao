//
//  HMAppDelegate.m
//  FutureMail
//
//  Created by Hao Liu on 12/22/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "HMAppDelegate.h"
#import "HMViewController.h"
#import "HMMainMenuViewController.h"
#import "HMTheme.h"

@interface HMAppDelegate ()

@property (strong, nonatomic) HMMainMenuViewController *menuController;

@end

@implementation HMAppDelegate

+ (HMAppDelegate *)appDelegate
{
    return (HMAppDelegate *)[[UIApplication sharedApplication] delegate];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Setup global theme.
    [HMTheme styleDefaultAppApperance];
    
    // Setup main menu.
    [self setupMainMenu];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
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
    if ([controller isKindOfClass:[HMViewController class]] && ((HMViewController *)controller).hasTransparentBackground)
    {
        [self.navigationController pushViewControllerWithTransparentBackground:controller animated:animated];
    }
    else
    {
        [self.navigationController pushViewController:controller animated:animated];
    }
}

- (UINavigationController*) navigationItem {
    return self.navigationController;
}

- (void)popToMenu
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)setupMainMenu
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    
    self.menuController = [[HMMainMenuViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.menuController];

    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
}


@end
