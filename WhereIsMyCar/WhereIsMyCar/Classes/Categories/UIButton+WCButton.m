//
//  UIButton+WCButton.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 8/27/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "UIButton+WCButton.h"

@implementation UIButton (WCButton)

- (void)setTitleForAllStates:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
    [self setTitle:title forState:UIControlStateDisabled];
    [self setTitle:title forState:UIControlStateSelected];
}

- (void)setTitleColorForAllStates:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateHighlighted];
    [self setTitleColor:color forState:UIControlStateDisabled];
    [self setTitleColor:color forState:UIControlStateSelected];
}

@end
