//
//  WCAboutViewController.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 10/14/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCAboutViewController.h"

@implementation WCAboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = NSLocalizedString(@"About", @"");
    
    UITextView *aboutLabel = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, self.contentView.frameWidth - 2 * 10, self.contentView.frameHeight - 2 * 10)];
    aboutLabel.backgroundColor = [UIColor clearColor];
    aboutLabel.text = NSLocalizedString(@"ENGLISH\n\nWelcome to ParkingTrack. \n\nParkingTrack provides an easy, fast way to track your car location and reminds you by using notification. This software is developed and maintained by Hao Liu (email: hao.liu0708@gmail.com). \n\nParkingTrack icon was made by Chris Fryer (email: cmfryer@gmail.com). \n\nCar pinner is made by mapicons (http://mapicons.nicolasmollet.com/)", @"");
    aboutLabel.font = [UIFont lightWCFontOfSize:13];
    aboutLabel.textAlignment = NSTextAlignmentLeft;
    aboutLabel.dataDetectorTypes = UIDataDetectorTypeAll;
    aboutLabel.textColor = [UIColor grayColor];
    aboutLabel.editable = NO;
    
    [self.contentView addSubview:aboutLabel];
}

@end
