//
//  WCMainMenuView.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 8/26/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCMainMenuView.h"
#import "WCMainMenuButton.h"
#import "WCCurrentParkingViewController.h"
#import "WCAppDelegate.h"
#import "WCFavoritesManager.h"
#import "WCFavoritesViewController.h"
#import "WCAboutViewController.h"

const CGFloat kMainMenuButtonPadding = 7;
const CGFloat kMainMenuTitleHeight = 40;
const CGFloat kMainMenuButtonsAreaHeight = 150;

const CGFloat kMainMenuMottoUpperLabelHeight = 35;
const CGFloat kMainMenuMottoLowerLabelHeight = 25;
const CGFloat kMainMenuBrandLabelHeight = 20;

@interface WCMainMenuView()

@property (strong) WCMainMenuButton *currentParkingButton;
@property (strong) WCMainMenuButton *historyParkingButton;
@property (strong) WCMainMenuButton *aboutButton;
@property (strong) WCMainMenuButton *settingsButton;

@property (strong) UIImageView *mainMenuBackgroundImageView;

@property (strong) UIView *buttonsAreaView;

@end


@implementation WCMainMenuView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initUI];
    }
    
    return self;
}

- (void)initUI
{
    self.mainMenuBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"parking_background.png"]];
    self.mainMenuBackgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.mainMenuBackgroundImageView.frame = CGRectMake(0, 0, self.frameWidth, self.frameHeight);
    self.mainMenuBackgroundImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:self.mainMenuBackgroundImageView];
    
    self.backgroundColor = [UIColor yellowColor];
    
    UILabel *mottoUpperLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, self.frameWidth, kMainMenuMottoUpperLabelHeight)];
    mottoUpperLabel.backgroundColor = [UIColor clearColor];
    mottoUpperLabel.textAlignment = NSTextAlignmentLeft;
    mottoUpperLabel.text = @"Parking Track";
    mottoUpperLabel.textColor = [UIColor whiteColor];
    mottoUpperLabel.font = [UIFont lightWCFontOfSize:kMainMenuMottoUpperLabelHeight * 0.8];
    [self addSubview:mottoUpperLabel];
    
    UILabel *mottoLowerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, mottoUpperLabel.frameBottom, self.frameWidth, kMainMenuMottoLowerLabelHeight)];
    mottoLowerLabel.backgroundColor = [UIColor clearColor];
    mottoLowerLabel.textAlignment = NSTextAlignmentLeft;
    mottoLowerLabel.text = @"location and time";
    mottoLowerLabel.textColor = [UIColor whiteColor];
    mottoLowerLabel.font = [UIFont lightWCFontOfSize:kMainMenuMottoLowerLabelHeight * 0.8];
    [self addSubview:mottoLowerLabel];
    
    
//    UILabel *brandLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.frameHeight - kMainMenuButtonsAreaHeight - kMainMenuBrandLabelHeight , self.frameWidth - 20, kMainMenuBrandLabelHeight)];
//    brandLabel.backgroundColor = [UIColor clearColor];
//    brandLabel.textAlignment = NSTextAlignmentRight;
//    brandLabel.text = @"ParkingTracker+";
//    brandLabel.textColor = [UIColor whiteColor];
//    brandLabel.font = [UIFont fontWithName:@"STHeitiJ-Medium" size:18];
//    [self addSubview:brandLabel];
    
    
    self.buttonsAreaView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frameHeight - kMainMenuButtonsAreaHeight, self.frameWidth, kMainMenuButtonsAreaHeight)];
    self.buttonsAreaView.backgroundColor = [UIColor clearColor];
    
    
    [self addSubview:self.buttonsAreaView];
    
    CGSize menuButtonSize = CGSizeMake((self.buttonsAreaView.frameWidth - kMainMenuButtonPadding * 3) / 2, (self.buttonsAreaView.frameHeight - kMainMenuButtonPadding * 3) / 2);
    
    self.currentParkingButton = [[WCMainMenuButton alloc] initWithFrame:CGRectMake(kMainMenuButtonPadding, kMainMenuButtonPadding, menuButtonSize.width, menuButtonSize.height)];
    self.currentParkingButton.title = @"My Car";
    self.currentParkingButton.titleLabel.font = [UIFont ultraLightWCFontOfSize:24];
    self.currentParkingButton.actionBlock = ^{
        WCCurrentParkingViewController *ctrlr = [[WCCurrentParkingViewController alloc] init];
        [[WCAppDelegate appDelegate] pushViewController:ctrlr animated:YES];
    };
    [self.buttonsAreaView addSubview:self.currentParkingButton];
    
    
    self.historyParkingButton = [[WCMainMenuButton alloc] initWithFrame:CGRectMake(menuButtonSize.width + kMainMenuButtonPadding * 2, kMainMenuButtonPadding, menuButtonSize.width, menuButtonSize.height)];
    self.historyParkingButton.title = @"Favorites";
    self.historyParkingButton.titleLabel.font = [UIFont ultraLightWCFontOfSize:24];
    self.historyParkingButton.actionBlock = ^{
        WCFavoritesViewController *ctrlr = [[WCFavoritesViewController alloc] init];
        [[WCAppDelegate appDelegate] pushViewController:ctrlr animated:YES];
    };
    [self.buttonsAreaView addSubview:self.historyParkingButton];
    
    
    self.aboutButton = [[WCMainMenuButton alloc] initWithFrame:CGRectMake(kMainMenuButtonPadding,
                                                                          menuButtonSize.height + kMainMenuButtonPadding * 2,
                                                                          menuButtonSize.width,
                                                                          menuButtonSize.height)];
    self.aboutButton.title = @"About";
    self.aboutButton.titleLabel.font = [UIFont ultraLightWCFontOfSize:24];
    self.aboutButton.actionBlock = ^{
        WCAboutViewController *ctrlr = [[WCAboutViewController alloc] init];
        [[WCAppDelegate appDelegate] pushViewController:ctrlr animated:YES];
    };
    [self.buttonsAreaView addSubview:self.aboutButton];
    
    
    self.settingsButton = [[WCMainMenuButton alloc] initWithFrame:CGRectMake(menuButtonSize.width + kMainMenuButtonPadding * 2,
                                                                             menuButtonSize.height + kMainMenuButtonPadding * 2,
                                                                             menuButtonSize.width,
                                                                             menuButtonSize.height)];
    self.settingsButton.title = @"Settings";
    self.settingsButton.titleLabel.font = [UIFont ultraLightWCFontOfSize:24];
    self.settingsButton.actionBlock = ^{
        IASKAppSettingsViewController *appSettingsViewController = [[IASKAppSettingsViewController alloc] init];
        appSettingsViewController.showDoneButton = NO;
        [[WCAppDelegate appDelegate] setCenterController:appSettingsViewController];
    };
    [self.buttonsAreaView addSubview:self.settingsButton];
}
@end
