//
//  NSNotificationCenter+WCAdditions.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 9/2/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "NSNotificationCenter+WCAdditions.h"

@implementation NSNotificationCenter (WCAdditions)

+ (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName
{
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:aName object:nil];
}

+ (void)postNamedNotification:(NSString *)aName
{
    [[NSNotificationCenter defaultCenter] postNotificationName:aName object:nil];
}

@end
