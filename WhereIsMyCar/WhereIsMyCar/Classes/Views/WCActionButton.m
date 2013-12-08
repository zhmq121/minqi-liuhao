//
//  WCActionButton.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 8/27/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCActionButton.h"

@implementation WCActionButton

- (void)setActionBlock:(WCVoidBlock)actionBlock
{
    _actionBlock = [actionBlock copy];
    
    if (actionBlock != nil)
        [self addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    else
        [self removeTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonPressed:(id)sender
{
    if (self.actionBlock != nil)
    {
        self.actionBlock();
    }
}

@end
