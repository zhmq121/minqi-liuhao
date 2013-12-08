//
//  WCMainMenuViewController.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 8/26/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCMainMenuViewController.h"
#import "WCMainMenuView.h"
#import "WCAppDelegate.h"

@interface WCMainMenuViewController ()

@property (strong) WCMainMenuView *menuView;

@end

@implementation WCMainMenuViewController

- (id)init
{
    if (self = [super init])
    {
        self.hideNavigationBar = YES;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.menuView = [[WCMainMenuView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.menuView];
}

@end
