//
//  WCCarAnnotationView.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 9/4/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCIconAnnotationView.h"
#import "WCPlace.h"

NSString *const WCIconAnnotationViewReuseIdentifier = @"WCIconAnnotationViewReuseIdentifier";

@interface WCIconAnnotationView()

@property (strong) UIImage *icon;
@property (strong) UIImageView *iconView;

@end



@implementation WCIconAnnotationView

- (id)initWithAnnotation:(id)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier])
    {
        [self setCalloutOffset:CGPointMake(0, -18)];
        
        // Add the pin icon
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(-16, -18, 32, 37)];
        [self addSubview:self.iconView];
    }
    return self;
}

- (void)setAnnotation:(id)annotation
{
    [super setAnnotation:annotation];
    
    WCPlace *place = (WCPlace *)annotation;
    self.icon = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", place.type]];
    
    [self.iconView setImage:self.icon];
}

@end
