//
//  WCConfigManager.h
//  WhereIsMyCar
//
//  Created by Hao Liu on 10/7/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

extern NSString const *WCConfigSettingsMapTypeKey;

@interface WCConfigManager : NSObject

+ (WCConfigManager *)sharedInstance;
- (void)loadSettings;
- (MKMapType)mapType;
- (NSInteger)notifyMeBefore;

@end
