//
//  MQInteractionViewController.h
//  TextKit
//
//  Created by Minqi Zhou on 12/14/13.
//  Copyright (c) 2013 Minqi Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MQInteractionViewController : UIViewController

@property (strong, nonatomic) UIView *clippyView;
@property (strong, nonatomic) UITextView *textView;
@property (nonatomic,strong) UIImageView *selectedImage;
-(id) initWithParameters:(NSTextStorage*)textStorage image:(UIImage*)image;
@end
