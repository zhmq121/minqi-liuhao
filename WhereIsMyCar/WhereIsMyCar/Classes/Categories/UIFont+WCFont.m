//
//  UIFont+WCFont.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 8/27/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "UIFont+WCFont.h"

@implementation UIFont (WCFont)

+ (UIFont *)WCFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
}

+ (UIFont *)lightWCFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
}

+ (UIFont *)ultraLightWCFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:fontSize];
}

@end
