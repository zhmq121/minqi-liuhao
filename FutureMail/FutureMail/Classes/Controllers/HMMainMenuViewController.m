//
//  HMMainMenuViewController.m
//  FutureMail
//
//  Created by Hao Liu on 12/22/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "HMMainMenuViewController.h"
#import "HMMainMenuView.h"
#import "HMAppDelegate.h"
@interface HMMainMenuViewController ()

@property (strong, nonatomic) HMMainMenuView *menuView;

@end

@implementation HMMainMenuViewController

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
    
    self.menuView = [[HMMainMenuView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.menuView];
}


@end
