//
//  WCViewController.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 8/26/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCViewController.h"

@interface WCViewController ()

@property (strong) ADBannerView *adBannerView;

@end

@implementation WCViewController

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:self.hideNavigationBar animated:animated];
    self.view.frame = [self maxViewFrame];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
    
    self.adBannerView = [[ADBannerView alloc] init];
    self.adBannerView.frameY = self.view.frameHeight - self.adBannerView.frameHeight;
    self.adBannerView.delegate = self;
    [self.view addSubview:self.adBannerView];
    
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frameWidth, self.view.frameHeight - self.adBannerView.frameHeight)];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.contentView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)enableViewNotifications
{
    //    [NSNotificationCenter addObserver:self selector:@selector(resizeViewFrame)
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{

}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    
}

@end
