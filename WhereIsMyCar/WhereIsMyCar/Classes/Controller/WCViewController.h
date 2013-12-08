//
//  WCViewController.h
//  WhereIsMyCar
//
//  Created by Hao Liu on 8/26/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const kNavigationBarPortraitHeight = 44;

@interface WCViewController : UIViewController<ADBannerViewDelegate>

@property (assign) BOOL hasTransparentBackground;
@property (assign) BOOL hideNavigationBar;

@property (strong) UIView *contentView;
- (CGRect)maxViewFrame;


@end
