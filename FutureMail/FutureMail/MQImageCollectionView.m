//
//  MQImageCollectionView.m
//  ImageTest
//
//  Created by Minqi Zhou on 12/15/13.
//  Copyright (c) 2013 Minqi Zhou. All rights reserved.
//

#import "MQImageCollectionView.h"

@implementation MQImageCollectionView
@synthesize image = _image;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        // Initialization code
    }
    return self;
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
