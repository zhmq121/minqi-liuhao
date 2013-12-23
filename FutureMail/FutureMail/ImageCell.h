//
//  ImageCell.h
//  ImageTest
//
//  Created by Minqi Zhou on 12/14/13.
//  Copyright (c) 2013 Minqi Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQImageCollectionView.h"

static NSString * const PhotoCellIdentifier = @"PhotoCell";
@interface ImageCell : UICollectionViewCell
@property (assign, nonatomic) int cellTag;
@property (strong, atomic) UIImageView *imageView;
@property (assign, nonatomic) BOOL isFiltered;

@end
