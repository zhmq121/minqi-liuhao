//
//  ImageCell.m
//  ImageTest
//
//  Created by Minqi Zhou on 12/14/13.
//  Copyright (c) 2013 Minqi Zhou. All rights reserved.
//

#import "ImageCell.h"
#import "CustomeCellBackGround.h"
@implementation ImageCell

@synthesize imageView = _imageView;
@synthesize cellTag = _cellTag;
NSInteger i = 1;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.cellTag = i++;
    self.imageView = imageView;
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    self.imageView.clipsToBounds = YES;
    self.userInteractionEnabled = YES;
    self.isFiltered = FALSE;
    CustomeCellBackGround *backgroundView = [[CustomeCellBackGround alloc] initWithFrame:CGRectZero];
    self.selectedBackgroundView = backgroundView;
    
    
    [self.contentView addSubview:self.imageView];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    NSLog(@"Cell %d is reused!", self.cellTag);
    self.imageView.image = nil;
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
