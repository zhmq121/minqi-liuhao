//
//  WCAppDataStore.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 9/6/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCAppDataStore.h"

@implementation WCAppDataStore

+ (NSInteger)integerForKey:(NSString *)defaultName
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    return [[NSUserDefaults standardUserDefaults] integerForKey:defaultName];
}

+ (id)objectForKey:(NSString *)defaultName
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

+ (void)setObject:(id)value forKey:(NSString *)defaultName
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)removeObjectForKey:(NSString *)defaultName
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:defaultName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)registerDefaults:(NSDictionary *)dict
{
    [[NSUserDefaults standardUserDefaults] registerDefaults:dict];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)synchronize
{
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
