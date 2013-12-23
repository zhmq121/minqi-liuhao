//
//  HMMainMenuView.m
//  FutureMail
//
//  Created by Hao Liu on 12/22/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "HMMainMenuView.h"
#import "HMMainMenuButton.h"
#import "HMMainMenuViewController.h"
#import "HMMailComposeViewController.h"
#import "HMAppDelegate.h"
#import "ColorPickerViewController.h"
#import "MQCollectionViewController.h"

const CGFloat kMainMenuButtonsAreaHeight = 150;
const CGFloat kMainMenuButtonPadding = 7;

@interface HMMainMenuView ()

@property (strong, nonatomic) UIImageView *mainMenuBackgroundImageView;
@property (strong, nonatomic) UIView *buttonsAreaView;
@property (strong, nonatomic) HMMainMenuButton *mainMenuButton1;
@property (strong, nonatomic) HMMainMenuButton *mainMenuButton2;
@property (strong, nonatomic) HMMainMenuButton *mainMenuButton3;
@property (strong, nonatomic) HMMainMenuButton *mainMenuButton4;
@end

@implementation HMMainMenuView

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
    self.mainMenuBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_menu_background.png"]];
    self.mainMenuBackgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.mainMenuBackgroundImageView.frame = CGRectMake(0, 0, self.frameWidth, self.frameHeight);
    self.mainMenuBackgroundImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:self.mainMenuBackgroundImageView];
    
    
    self.buttonsAreaView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frameHeight - kMainMenuButtonsAreaHeight, self.frameWidth, kMainMenuButtonsAreaHeight)];
    self.buttonsAreaView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.buttonsAreaView];
    
    
    CGSize menuButtonSize = CGSizeMake((self.buttonsAreaView.frameWidth - kMainMenuButtonPadding * 3) / 2, (self.buttonsAreaView.frameHeight - kMainMenuButtonPadding * 3) / 2);
    
    self.mainMenuButton1 = [[HMMainMenuButton alloc] initWithFrame:CGRectMake(kMainMenuButtonPadding, kMainMenuButtonPadding, menuButtonSize.width, menuButtonSize.height)];
    [self.mainMenuButton1 setupAsGreenButton];
    self.mainMenuButton1.title = NSLocalizedString(@"Compose Mail", @"");
    self.mainMenuButton1.titleLabel.font = [UIFont ultraLightHMFontOfSize:24];
    self.mainMenuButton1.actionBlock = ^{
         MQCollectionViewController *ctrlr = [[MQCollectionViewController alloc] init];
        [[HMAppDelegate appDelegate] pushViewController:ctrlr animated:YES];

        // Push the controller
        // Example:
//        HMCurrentParkingViewController *ctrlr = [[WCCurrentParkingViewController alloc] init];
//        [[WCAppDelegate appDelegate] pushViewController:ctrlr animated:YES];
    };
    [self.buttonsAreaView addSubview:self.mainMenuButton1];
    
    
    self.mainMenuButton2 = [[HMMainMenuButton alloc] initWithFrame:CGRectMake(menuButtonSize.width + kMainMenuButtonPadding * 2, kMainMenuButtonPadding, menuButtonSize.width, menuButtonSize.height)];
    [self.mainMenuButton2 setupAsGreenButton];
    self.mainMenuButton2.title = NSLocalizedString(@"Button 2", @"");
    self.mainMenuButton2.titleLabel.font = [UIFont ultraLightHMFontOfSize:24];
    self.mainMenuButton2.actionBlock = ^{
        // TODO
    };
    [self.buttonsAreaView addSubview:self.mainMenuButton2];
    
    
    self.mainMenuButton3 = [[HMMainMenuButton alloc] initWithFrame:CGRectMake(kMainMenuButtonPadding,
                                                                          menuButtonSize.height + kMainMenuButtonPadding * 2,
                                                                          menuButtonSize.width,
                                                                          menuButtonSize.height)];
    [self.mainMenuButton3 setupAsGreenButton];
    self.mainMenuButton3.title = NSLocalizedString(@"Button 3", @"");
    self.mainMenuButton3.titleLabel.font = [UIFont ultraLightHMFontOfSize:24];
    self.mainMenuButton3.actionBlock = ^{
        // TODO
    };
    [self.buttonsAreaView addSubview:self.mainMenuButton3];
    
    
    self.mainMenuButton4 = [[HMMainMenuButton alloc] initWithFrame:CGRectMake(menuButtonSize.width + kMainMenuButtonPadding * 2,
                                                                             menuButtonSize.height + kMainMenuButtonPadding * 2,
                                                                             menuButtonSize.width,
                                                                             menuButtonSize.height)];
    [self.mainMenuButton4 setupAsGreenButton];
    self.mainMenuButton4.title = @"Settings";
    self.mainMenuButton4.titleLabel.font = [UIFont ultraLightHMFontOfSize:24];
    self.mainMenuButton4.actionBlock = ^{
        // TODO
    };
    [self.buttonsAreaView addSubview:self.mainMenuButton4];
}



@end
