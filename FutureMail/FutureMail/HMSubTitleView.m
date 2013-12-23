//
//  HMSubTitleView.m
//  FutureMail
//
//  Created by Minqi Zhou on 1/3/14.
//  Copyright (c) 2014 Hao Liu. All rights reserved.
//

#import "HMSubTitleView.h"
#import "HMAppDelegate.h"

@implementation HMSubTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setup {
    UIImageView *detailView = [[UIImageView alloc] init];
    UILabel *caption =[[UILabel alloc] initWithFrame:CGRectMake(140, 300, 300, 60)];
    [detailView setTag:detailViewTag];
    detailView.frame = CGRectInset([[UIScreen mainScreen] bounds], 20, 90);
    detailView.center = CGPointMake(detailView.center.x, detailView.center.y - 60);
    [detailView setImage:[UIImage imageNamed:@"dog.jpg"]];
    detailView.contentMode = UIViewContentModeScaleAspectFit;
    
    CGPoint textCenter = detailView.center;
    [caption setTag:captionTag];
    [caption setText:@"Woof, please pick the picture"];
    [caption setFont:[UIFont fontWithName:@"Chalkduster" size:15]];
    [caption setTextColor:[UIColor whiteColor]];
    textCenter.y += 120;
    [caption setCenter:textCenter];
    caption.textAlignment = NSTextAlignmentCenter;
    
    
    [self addSubview:detailView];
    [self addSubview:caption];
    [self setBackgroundColor:[UIColor blackColor]];
    //[self.view setBackgroundColor:[UIColor colorWithRed:48.0f/255 green:214.0f/255 blue:255.0f/255 alpha:1]];
    
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
