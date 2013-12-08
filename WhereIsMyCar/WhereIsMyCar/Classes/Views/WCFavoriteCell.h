//
//  WCFavoriteCell.h
//  WhereIsMyCar
//
//  Created by Hao Liu on 9/8/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCFavorite.h"

@interface WCFavoriteCell : UITableViewCell

@property (nonatomic, strong) WCFavorite *favorite;
@property (assign) BOOL isSelected;
@property (assign, nonatomic) BOOL isEditing;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

+ (CGFloat)heightForCell;

@end
