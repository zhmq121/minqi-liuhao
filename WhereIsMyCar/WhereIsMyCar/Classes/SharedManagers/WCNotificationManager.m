//
//  WCNotificationManager.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 10/13/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCNotificationManager.h"
#import "WCAppDataManager.h"
#import "WCConfigManager.h"
#import "WCUtils.h"

@implementation WCNotificationManager

+ (WCNotificationManager *)sharedInstance
{
    static WCNotificationManager *sharedManager = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

- (void)scheduleTimerNotification
{
    // Cancel all previous notifications
    [self cancelAllNotifications];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    if (localNotification != nil)
    {
        NSDate *nowDate = [NSDate date];
        NSDate *expiryDate = [WCAppDataManager sharedInstance].expireDate;
        NSInteger diff = [expiryDate timeIntervalSinceNow] / 60;
        NSDate *fireDate;
        NSInteger duration = 0;
        // Use setting time inteval
        if (diff >= [WCConfigManager sharedInstance].notifyMeBefore)
        {
            fireDate = [expiryDate dateByAddingTimeInterval:-([WCConfigManager sharedInstance].notifyMeBefore * 60)];
            duration = [WCConfigManager sharedInstance].notifyMeBefore;
        }
        else
        {
            fireDate = [NSDate date];
            duration = diff;
        }
        localNotification.alertBody = [NSString stringWithFormat:NSLocalizedString(@"Parking meter will expire in %d minutes.\nNow: %@\nExpiry Time: %@", @""), duration, getHourAndMinutePartsFromDate(nowDate), getHourAndMinutePartsFromDate(expiryDate)];
        localNotification.fireDate = fireDate;
        localNotification.repeatInterval = 0;
        localNotification.timeZone = [NSTimeZone systemTimeZone];
        localNotification.alertAction = NSLocalizedString(@"View", @"");
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        NSLog(@"Notification scheduled");
    }
}

- (void)cancelAllNotifications
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    NSLog(@"All notifications cancelled");
}

@end
