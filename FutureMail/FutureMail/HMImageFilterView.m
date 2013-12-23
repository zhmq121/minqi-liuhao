//
//  HMImageFilterView.m
//  FutureMail
//
//  Created by Minqi Zhou on 1/5/14.
//  Copyright (c) 2014 Hao Liu. All rights reserved.
//

#import "HMImageFilterView.h"
#import "MQImageCollectionView.h"
#import "HMSubTitleView.h"
#import "ImageCell.h"
#import "ImageUtil.h"



@implementation HMImageFilterView
@synthesize cellImages = _cellImages;
@synthesize collectionView = _collectionView;
@synthesize currImage = _currImage;
@synthesize detailView = _detailView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup {
    //self.cellImages = [[NSMutableArray alloc] init];
    
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f);
    //layout.itemSize = CGSizeMake(25.0f, 25.0f);
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    UIImageView *detailView = [[UIImageView alloc] init];
    [detailView setTag:detailViewTag];
    detailView.frame = CGRectInset([[UIScreen mainScreen] bounds], 30, 80);
    detailView.center = CGPointMake(detailView.center.x, detailView.center.y - 60);
    self.detailView = detailView;
    
    MQImageCollectionView *collectionView = [[MQImageCollectionView alloc] initWithFrame:[[UIScreen mainScreen] bounds] collectionViewLayout:layout];
    collectionView.frame = CGRectMake(0, collectionView.frameHeight - 60, collectionView.frameWidth, 60);
    collectionView.frame = CGRectMake(0, 360, collectionView.frameWidth, 60);
    [collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:kCellID];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView setBackgroundColor:[UIColor grayColor]];
    self.collectionView = collectionView;
    
    [self addSubview:detailView];
    [self addSubview:collectionView];
    [self setBackgroundColor:[UIColor colorWithRed:48.0f/255 green:214.0f/255 blue:255.0f/255 alpha:1]];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return 9;
}


- (ImageCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    
    ImageCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    // load the image for this cell
    
    cell.imageView = [[UIImageView alloc] initWithImage:self.currImage];
    cell.imageView.image = [self filterOnImage:cell.imageView.image cellIndex:indexPath.row size:CGSizeMake(50, 50)];
    //cell.imageView.image = [ImageUtil resizeImage:cell.imageView.image scaledToSize:CGSizeMake(50, 50)];
    
    [cell.imageView setNeedsDisplay];
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
    cell.imageView.frame = CGRectMake(0, 0, 50, 50);
    //cell.imageView.clipsToBounds = YES;
    cell.isFiltered = TRUE;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(respondToTapGesture:)];
    
    // Specify that the gesture must be a single tap
    tapRecognizer.numberOfTapsRequired = 1;
    
    // Add the tap gesture recognizer to the view
    [self.collectionView addGestureRecognizer:tapRecognizer];
    
    // Do any additional setup after loading the view.
    
    cell.backgroundColor= [UIColor blackColor];
    [cell.contentView addSubview:cell.imageView];
    
    return cell;
}

- (void)respondToTapGesture:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint p = [gestureRecognizer locationInView:self.collectionView];
    ImageCell *cell;
    NSIndexPath *indexPath = [[self collectionView] indexPathForItemAtPoint:p];
    if (indexPath != nil) {
        cell = (ImageCell*)[[self collectionView] cellForItemAtIndexPath:indexPath];
    }
    
    if (cell == nil) {
        return;
    }
    UIImageView *detailView = (UIImageView*)[self viewWithTag:detailViewTag];
    CGRect rectSize = CGRectInset([[UIScreen mainScreen] bounds], 30, 80);
    detailView.image = [self filterOnImage:self.currImage cellIndex:indexPath.row size:rectSize.size];
    detailView.frame = rectSize;
    detailView.center = CGPointMake(detailView.center.x, detailView.center.y - 60);
    detailView.contentMode = UIViewContentModeScaleToFill;
}

- (UIImage*)filterOnImage:(UIImage*)image cellIndex:(NSInteger)cellIndex size:(CGSize)size {
    CIContext *context = [CIContext contextWithOptions:nil];
    //UIImage *resizedImage = [ImageUtil resizeImage:cell.imageView.image scaledToSize:CGSizeMake(50, 50)];
    UIImage *resizedImage = [ImageUtil resizeImage:image scaledToSize:size];
    CIImage *tImage = [[CIImage alloc] initWithCGImage:resizedImage.CGImage];
    
    CIFilter *filter;
    if (cellIndex == 0 ) {
        filter = [CIFilter filterWithName:@"CIPhotoEffectInstant"];
    } else if (cellIndex == 1 ) {
        filter = [CIFilter filterWithName:@"CIColorControls"];
        [filter setValue:[NSNumber numberWithFloat:1.0f]  forKey:@"inputSaturation"];
        [filter setValue:[NSNumber numberWithFloat:0.0f] forKey:@"inputBrightness"];
        [filter setValue:[NSNumber numberWithFloat:1.0f] forKey:@"inputContrast"];
    } else if (cellIndex == 2 ) {
        filter = [CIFilter filterWithName:@"CIExposureAdjust"];
        [filter setValue:[NSNumber numberWithFloat:1.0f]  forKey:kCIInputEVKey];
    } else if (cellIndex == 3 ) {
        filter = [CIFilter filterWithName:@"CIGaussianBlur"];
        [filter setValue:[NSNumber numberWithFloat:12.0f]  forKey:kCIInputRadiusKey];
    } else if (cellIndex == 4 ) {
        filter = [CIFilter filterWithName:@"CILinearToSRGBToneCurve"];
    } else if (cellIndex == 5 ) {
        filter = [CIFilter filterWithName:@"CIHighlightShadowAdjust"];
        [filter setValue:[NSNumber numberWithFloat:1.0f]  forKey:@"inputHighlightAmount"];
        [filter setValue:[NSNumber numberWithFloat:0.5f]  forKey:@"inputShadowAmount"];
    } else if (cellIndex == 6 ) {
        filter = [CIFilter filterWithName:@"CIColorClamp"];
        [filter setValue:[[CIVector alloc] initWithX:0.1 Y:0.1 Z:0.2 W:0.1]  forKey:@"inputMinComponents"];
        [filter setValue:[[CIVector alloc] initWithX:0.9 Y:0.9 Z:0.9 W:0.9]  forKey:@"inputMaxComponents"];
    } else if (cellIndex == 7 ) {
        filter = [CIFilter filterWithName:@"CIPhotoEffectFade"];
    } else if (cellIndex == 8 ) {
        filter = [CIFilter filterWithName:@"CIPhotoEffectChrome"];
    }
    [filter setValue:tImage forKey:kCIInputImageKey];
    CIImage *output = [filter valueForKey:kCIOutputImageKey];
    CGRect extent = [output extent];
    CGImageRef oImage = [context createCGImage:output fromRect:extent];
    
    //[self.cellImages addObject:[[UIImage alloc] initWithCGImage:oImage]];
    return [[UIImage alloc] initWithCGImage:oImage];
    
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
