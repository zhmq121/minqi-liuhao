//
//  HMMailComposeViewController.h
//  FutureMail
//
//  Created by Minqi Zhou on 12/22/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "HMViewController.h"

@interface HMMailComposeViewController : HMViewController
@property (nonatomic,strong) UIImageView *selectedImage;

- (void) selectImage:(UIImage*)image;
@end
