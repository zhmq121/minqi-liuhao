//
//  UIFont+WCFont.h
//  WhereIsMyCar
//
//  Created by Hao Liu on 8/27/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (WCFont)

+ (UIFont *)WCFontOfSize:(CGFloat)fontSize;
+ (UIFont *)lightWCFontOfSize:(CGFloat)fontSize;
+ (UIFont *)ultraLightWCFontOfSize:(CGFloat)fontSize;

@end