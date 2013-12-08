//
//  WCFavoriteCell.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 9/8/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCFavoriteCell.h"

const CGFloat kFavoriteCellGapHeight = 6.0;
const CGFloat kFavoriteCellHeight = 105;
const CGFloat kLabelLeftMargin = 19.0;
const CGFloat kNoteLabelTopMargin = 13.0;
const CGFloat kNoteLabelHeight = 22;
const CGFloat kAddressLabelMarginWithNoteLabel = 2;
const CGFloat kAddressLabelHeight = 60;

@interface WCFavoriteCell()

@property (strong) UIView *cellBackground;
@property (strong) UILabel *noteLabel;
@property (strong) UILabel *addressLabel;
@property (strong) UILabel *dateLabel;
@property (strong) UIButton *toggleButton;

@end

@implementation WCFavoriteCell

- (void)setFavorite:(WCFavorite *)favorite
{
    if (_favorite == favorite)
        return;
    
    _favorite = favorite;
    
    if (_favorite != nil)
    {
        [self updateUI];
    }
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])
    {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.toggleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    self.toggleButton.hidden = YES;
    [self.toggleButton addTarget:self action:@selector(toggleButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.toggleButton setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [self.toggleButton setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    self.accessoryView = self.toggleButton;
    
    self.cellBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frameWidth, kFavoriteCellHeight)];
    self.cellBackground.backgroundColor = [UIColor WCGrayColor];
    self.cellBackground.alpha = 0.8;
    [self.contentView addSubview:self.cellBackground];
    
    self.noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLabelLeftMargin, kNoteLabelTopMargin, self.frameWidth - 2 * kLabelLeftMargin, kNoteLabelHeight)];
    self.noteLabel.backgroundColor = [UIColor clearColor];
    self.noteLabel.textColor = [UIColor whiteColor];
    self.noteLabel.font = [UIFont lightWCFontOfSize:17];
    [self.contentView addSubview:self.noteLabel];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(kLabelLeftMargin, self.noteLabel.frameBottom + kAddressLabelMarginWithNoteLabel, self.frameWidth - 2 * kLabelLeftMargin, kAddressLabelHeight)];
    self.addressLabel.backgroundColor = [UIColor clearColor];
    self.addressLabel.textColor = [UIColor whiteColor];
    self.addressLabel.numberOfLines = 3;
    self.addressLabel.font = [UIFont lightWCFontOfSize:14];
    [self.contentView addSubview:self.addressLabel];
}

- (void)toggleButtonClicked
{
    self.toggleButton.selected = !self.toggleButton.selected;
    self.isSelected = self.toggleButton.isSelected;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)updateUI
{
    if (self.favorite.note != nil)
        self.noteLabel.text = self.favorite.note;
    else
        self.noteLabel.text = NSLocalizedString(@"no name", @"");
    
    self.addressLabel.text = self.favorite.address;
    // todo: date
}

+ (CGFloat)heightForCell
{
    return kFavoriteCellHeight + kFavoriteCellGapHeight;
}

- (void)setIsEditing:(BOOL)isEditing
{
    // reset toggleButton to unselected
    self.toggleButton.selected = NO;
    if (isEditing)
    {
        self.toggleButton.hidden = NO;
    }
    else
    {
        self.toggleButton.hidden = YES;
    }
}

@end
