//
//  WCNotificationManager.h
//  WhereIsMyCar
//
//  Created by Hao Liu on 10/13/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

@interface WCNotificationManager : NSObject

+ (WCNotificationManager *)sharedInstance;
- (void)scheduleTimerNotification;
- (void)cancelAllNotifications;

@end
