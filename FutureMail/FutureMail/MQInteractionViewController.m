//
//  MQInteractionViewController.m
//  TextKitDemo
//
//  Created by Minqi Zhou on 12/14/13.
//  Copyright (c) 2013 Minqi Zhou. All rights reserved.
//

#import "MQInteractionViewController.h"
#import "HMEmailComposerView.h"
const static NSInteger textTag = 1;
const static NSInteger imageTag = 2;

@interface MQInteractionViewController () <UITextViewDelegate>
{
	CGPoint _panOffset;
}
@end

@implementation MQInteractionViewController
@synthesize textView = _textView;
@synthesize selectedImage = _selectedImage;

-(id) initWithParameters:(NSTextStorage*)textStorage image:(UIImage*)image  {
    self = [super init];
    if(self) {
        
        NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
        [textStorage addLayoutManager:layoutManager];
        NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:self.view.bounds.size];
        [layoutManager addTextContainer:textContainer];
        UITextView* textView = [[UITextView alloc] initWithFrame:self.view.bounds textContainer:textContainer];
        [textView setTag:textTag];
        
        self.textView = textView;
        self.textView.delegate = self;
        self.textView.layoutManager.hyphenationFactor = 1.0;    // Enable hyphenation
        [self.view addSubview:textView];
        
        UIImageView *imageView =[[UIImageView alloc] init];
        CGRect rectSize = CGRectInset([[UIScreen mainScreen] bounds], 30, 80);
        imageView.frame = rectSize;
        imageView.center = CGPointMake(imageView.center.x, imageView.center.y - 60);
        imageView.image = image;
        
        imageView.contentMode = UIViewContentModeScaleToFill;
        //imageView.frame = CGRectInset([[UIScreen mainScreen] bounds], 30, 80);
        imageView.userInteractionEnabled = YES;


        self.selectedImage = imageView;
        [self.selectedImage addGestureRecognizer: [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(updateLocale:)]];

        [self.view addSubview:self.selectedImage];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.clippyView.hidden = YES;
        
        [self updateExclusionPaths];
    }
    return self;
}


- (void)viewDidLoad
{
	[super viewDidLoad];
	
}


#pragma mark - Exclusion

- (void)updateLocale:(UIPanGestureRecognizer *)pan
{
	// Capute offset in view on begin
	if (pan.state == UIGestureRecognizerStateBegan)
		_panOffset = [pan locationInView: self.selectedImage];
	
	// Update view location
	CGPoint location = [pan locationInView: self.view];
	CGPoint imageCenter = self.selectedImage.center;
	
	imageCenter.x = location.x - _panOffset.x + self.selectedImage.frame.size.width / 2;
	imageCenter.y = location.y - _panOffset.y + self.selectedImage.frame.size.width / 2;
	self.selectedImage.center = imageCenter;
	
	// Update exclusion path
	[self updateExclusionPaths];
}

- (void)updateExclusionPaths
{
	CGRect rectFrame = [self.textView convertRect:self.selectedImage.bounds fromView:self.selectedImage];
	
	// Since text container does not know about the inset, we must shift the frame to container coordinates
	rectFrame.origin.x -= self.textView.textContainerInset.left;
	rectFrame.origin.y -= self.textView.textContainerInset.top;
	
	// Simply set the exclusion path
	UIBezierPath *recPath = [UIBezierPath bezierPathWithRect:rectFrame];
	self.textView.textContainer.exclusionPaths = @[recPath];
	
}



@end
