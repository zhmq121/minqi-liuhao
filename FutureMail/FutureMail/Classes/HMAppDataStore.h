//
//  HMAppDataStore.h
//  FutureMail
//
//  Created by Hao Liu on 12/22/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

@interface HMAppDataStore : NSObject

+ (id)objectForKey:(NSString *)defaultName;
+ (void)setObject:(id)value forKey:(NSString *)defaultName;
+ (void)removeObjectForKey:(NSString *)defaultName;
+ (void)registerDefaults:(NSDictionary *)dict;
+ (void)synchronize;

@end
