//
//  HMActionButton.m
//  FutureMail
//
//  Created by Hao Liu on 12/22/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "HMActionButton.h"

@implementation HMActionButton

- (void)setActionBlock:(HMVoidBlock)actionBlock
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
