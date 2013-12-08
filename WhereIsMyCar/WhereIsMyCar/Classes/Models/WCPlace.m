//
//  WCPlace.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 9/4/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCPlace.h"

NSString *const WCPlaceTypeCar = @"car";
NSString *const WCPlaceTypeParked = @"parked";

@interface WCPlace()

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (strong) NSString *value;

@end

@implementation WCPlace

- (id)copyWithZone:(NSZone *)zone
{
    WCPlace *copy = [[WCPlace alloc] init];
    copy.coordinate = self.coordinate;
    copy.title = [self.title copyWithZone:zone];
    copy.title = [self.subtitle copyWithZone:zone];
    return copy;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate withType:(NSString *)type
{
    self.coordinate = coordinate;
    self.type = type;
    
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
}

- (void)setSubtitle:(NSString *)subtitle
{
    _subtitle = subtitle;
}

@end
