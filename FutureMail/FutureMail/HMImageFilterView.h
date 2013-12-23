//
//  HMImageFilterView.h
//  FutureMail
//
//  Created by Minqi Zhou on 1/5/14.
//  Copyright (c) 2014 Hao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCell.h"
const static NSInteger currImageTag = 2;

const static NSString *kCellID = @"PhotoCell";

@interface HMImageFilterView : UIView <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *cellImages;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImage *currImage;
@property (nonatomic, strong) UIImageView *detailView;
@end
