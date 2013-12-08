//
//  WCAppDataManager.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 9/5/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCAppDataManager.h"
#import "WCAppDataStore.h"

NSString *const WCAppDataStoreCarPlaceKey = @"WCAppDataStoreCarPlaceKey";
NSString *const WCAppDataStoreExpireDateKey = @"WCAppDataStoreExpireDateKey";

@interface WCAppDataManager()

@end

@implementation WCAppDataManager

+ (WCAppDataManager *)sharedInstance
{
    static WCAppDataManager *sharedManager = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

- (WCPlace *)carPlace
{
    NSDictionary *dict = [WCAppDataStore objectForKey:WCAppDataStoreCarPlaceKey];
    if (dict != nil)
    {
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [[dict objectForKey:@"lat"] doubleValue];
        coordinate.longitude = [[dict objectForKey:@"long"] doubleValue];
        
        WCPlace *result = [[WCPlace alloc] initWithCoordinate:coordinate withType:WCPlaceTypeCar];
        result.title = [dict objectForKey:@"title"];
        result.subtitle = [dict objectForKey:@"subtitle"];
        
        return result;
    }
    else
    {
        return nil;
    }
}

- (void)setCarPlace:(WCPlace *)carPlace
{
    NSMutableDictionary *dict = nil;
    if (carPlace != nil)
    {
        dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[[NSNumber alloc] initWithDouble:carPlace.coordinate.latitude] forKey:@"lat"];
        [dict setObject:[[NSNumber alloc] initWithDouble:carPlace.coordinate.longitude] forKey:@"long"];
        [dict setObject:carPlace.title forKey:@"title"];
        [dict setObject:carPlace.subtitle forKey:@"subtitle"];
    }

    [WCAppDataStore setObject:dict forKey:WCAppDataStoreCarPlaceKey];
}

- (NSDate *)expireDate
{
    return [WCAppDataStore objectForKey:WCAppDataStoreExpireDateKey];
}

- (void)setExpireDate:(NSDate *)expireDate
{
    [WCAppDataStore setObject:expireDate forKey:WCAppDataStoreExpireDateKey];
}

@end
