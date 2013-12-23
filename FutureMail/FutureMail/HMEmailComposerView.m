//
//  HMEmailComposerView.m
//  FutureMail
//
//  Created by Minqi Zhou on 12/25/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "HMEmailComposerView.h"
#import "HMAppDelegate.h"
#import "MQInteractionViewController.h"
#import <QuartzCore/QuartzCore.h> 

const CGFloat kLabelHeight = 40;
const CGFloat kLabelWidth = 60;
const CGFloat padding = 10;
const CGFloat topPadding = 15;
const CGFloat buttomPadding = 10;
const CGFloat buttonWidth = 50;
const CGFloat buttonHeight = 50;

@implementation HMEmailComposerView
@synthesize recipient = _recipient;
@synthesize body = _body;
@synthesize doneButton = _doneButton;
@synthesize sendButton = _sendButton;
@synthesize delegate = _delegate;
@synthesize ctrlr = _ctrlr;
@synthesize selectedImage = _selectedImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (void) setup:(CGRect)frame {
    UILabel *recipientLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, topPadding, kLabelWidth, kLabelHeight)];
    self.translatesAutoresizingMaskIntoConstraints = YES;

    recipientLabel.text = @"To:";
    recipientLabel.font = [UIFont systemFontOfSize:15];
    recipientLabel.textAlignment = NSTextAlignmentCenter;

    
    self.recipient = [[UITextField alloc] initWithFrame:CGRectMake(kLabelWidth + 2 * padding, topPadding, self.frameWidth - 3 * padding - kLabelWidth, kLabelHeight)];
    self.recipient.tag = 1;
    self.recipient.placeholder = @"example@abc.com";
    self.recipient.alpha = 0.5f;
    self.recipient.borderStyle = UITextBorderStyleRoundedRect;
    self.recipient.autocorrectionType = UITextAutocorrectionTypeNo;
    self.recipient.keyboardType = UIKeyboardTypeDefault;
    self.recipient.returnKeyType = UIReturnKeyDone;
    self.recipient.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.recipient.delegate = self;
    NSLog(@"%f %f", frame.size.width, frame.size.height);
    self.body = [[UITextView alloc] initWithFrame:CGRectMake(padding, kLabelHeight + padding + topPadding, frame.size.width - 2 * padding, frame.size.height - 4 * padding - buttomPadding - topPadding - kLabelHeight - buttonHeight)];
    self.body.backgroundColor = [UIColor whiteColor];
    self.body.tag = 2;
    self.body.autocorrectionType = UITextAutocorrectionTypeYes;
    self.body.keyboardType = UIKeyboardTypeDefault;
    self.body.returnKeyType = UIReturnKeyDone;
    self.body.delegate = self;
    self.body.textContainerInset = UIEdgeInsetsMake(4,8,4,8);
    [[self.body layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.body layer] setBorderWidth:2.3];
    [[self.body layer] setCornerRadius:15];
    
    self.ctrlr = [[ColorPickerViewController alloc] init];
    
    self.doneButton = [[MOGlassButton alloc] initWithFrame:CGRectMake(padding, kLabelHeight + self.body.frameHeight + 2 * padding + topPadding, buttonWidth, buttonHeight)];
    [self.doneButton setImage:[UIImage imageNamed:@"painter_button.jpg"] forState:UIControlStateNormal];
    //[self.doneButton setupAsOrangeButton];
    //[self.doneButton setTitle:@"Done" forState:UIControlStateNormal];
    //[self.doneButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:15.0]];
    self.ctrlr.delegate = self.delegate;
    self.doneButton.actionBlock = ^{
        [self.delegate presentModalViewController:self.ctrlr animated:YES];
    };
    
    self.sendButton = [[MOGlassButton alloc] initWithFrame:CGRectMake(2 * padding + buttonWidth, kLabelHeight + self.body.frameHeight + 2 * padding + topPadding, buttonWidth, buttonHeight)];
    [self.sendButton setImage:[UIImage imageNamed:@"send_button.jpg"] forState:UIControlStateNormal];
    self.sendButton.actionBlock = ^{
        MQInteractionViewController *vc = [[MQInteractionViewController alloc] initWithParameters:self.body.textStorage image:self.selectedImage];

        [[HMAppDelegate appDelegate] pushViewController:vc animated:YES];
    };

    self.backgroundColor = [UIColor colorWithRed:48.0f/255 green:214.0f/255 blue:255.0f/255 alpha:1];
    [self addSubview:recipientLabel];
    [self addSubview:self.recipient];
    [self addSubview:self.body];
    [self addSubview:self.doneButton];
    [self addSubview:self.sendButton];
    

}

- (UITextRange*) textRange {
    UITextRange *range = [self.body selectedTextRange];
    return range;
    
}

- (void) registerDelegate:(HMViewController*)vc {
    self.delegate = vc;
    self.ctrlr.delegate = vc;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [self.recipient resignFirstResponder];
    //[self.body resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


#pragma mark NSCoding

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.body forKey:kBodyKey];
    [coder encodeObject:self.recipient   forKey:kRecipientKey];
    [coder encodeObject:self.selectedImage forKey:kImageKey];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

