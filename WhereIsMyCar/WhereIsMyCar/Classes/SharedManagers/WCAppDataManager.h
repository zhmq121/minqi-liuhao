//
//  WCAppDataManager.h
//  WhereIsMyCar
//
//  Created by Hao Liu on 9/5/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCPlace.h"

extern NSString *const WCAppDataStoreCarPlaceKey;
extern NSString *const WCAppDataStoreExpireDateKey;

@interface WCAppDataManager : NSObject

@property (strong, nonatomic) WCPlace *carPlace;
@property (strong, nonatomic) NSDate *expireDate;

+ (WCAppDataManager *)sharedInstance;

@end
