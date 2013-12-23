//
//  HMViewController.m
//  FutureMail
//
//  Created by Hao Liu on 12/22/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "HMViewController.h"

static CGFloat const kNavigationBarPortraitHeight = 44;

@implementation HMViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.hideNavigationBar = NO;
        self.hasTransparentBackground = NO;
        [self enableViewNotifications];
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:self.maxViewFrame];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:self.hideNavigationBar animated:animated];
    self.view.frame = [self maxViewFrame];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(NSFoundationVersionNumber_iOS_7_0))
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.clipsToBounds = YES;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", @"") style:UIBarButtonItemStyleBordered target:nil action:nil];
}

- (void)enableViewNotifications
{
    // Add basic notifications for base view controller
}

- (CGRect)maxViewFrame
{
    CGRect maxFrame = [UIScreen mainScreen].applicationFrame;
    maxFrame.origin = CGPointZero;
    
    if (self.navigationController && self.hideNavigationBar == NO)
    {
        maxFrame.size.height -= kNavigationBarPortraitHeight;
    }
    else if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(NSFoundationVersionNumber_iOS_7_0))
    {
        maxFrame.size.height += [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    
    return maxFrame;
}

@end
