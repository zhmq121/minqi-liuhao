//
//  HMEmailComposerView.h
//  FutureMail
//
//  Created by Minqi Zhou on 12/25/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MOGlassButton.h"
#import "HMMainMenuButton.h"
#import "ColorPickerViewController.h"
#import "HMViewController.h"

#define kBodyKey            @"Body"
#define kRecipientKey       @"Recipient"
#define kImageKey           @"Image"



@interface HMEmailComposerView : UIView <UITextViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UITextField *recipient;
@property (nonatomic, strong) UITextView *body;
@property (nonatomic, strong) MOGlassButton *doneButton;
@property (nonatomic, strong) MOGlassButton *sendButton;
@property (nonatomic, strong) HMViewController *delegate;
@property (nonatomic, strong) ColorPickerViewController *ctrlr;
@property (nonatomic, strong) UIImage *selectedImage;
- (void) registerDelegate:(UIViewController*)vc;
@end
