//
//  WCActionButton.h
//  WhereIsMyCar
//
//  Created by Hao Liu on 8/27/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCActionButton : UIButton

@property (copy, nonatomic) WCVoidBlock actionBlock;

@end
