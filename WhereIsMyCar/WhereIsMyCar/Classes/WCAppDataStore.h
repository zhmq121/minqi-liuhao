//
//  WCAppDataStore.h
//  WhereIsMyCar
//
//  Created by Hao Liu on 9/6/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//


@interface WCAppDataStore : NSObject

+ (NSInteger)integerForKey:(NSString *)defaultName;
+ (id)objectForKey:(NSString *)defaultName;
+ (void)setObject:(id)value forKey:(NSString *)defaultName;
+ (void)removeObjectForKey:(NSString *)defaultName;
+ (void)registerDefaults:(NSDictionary *)dict;
+ (void)synchronize;
@end
