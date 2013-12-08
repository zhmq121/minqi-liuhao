//
//  NSNotificationCenter+WCAdditions.h
//  WhereIsMyCar
//
//  Created by Hao Liu on 9/2/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (WCAdditions)

+ (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName;
+ (void)postNamedNotification:(NSString *)aName;

@end
