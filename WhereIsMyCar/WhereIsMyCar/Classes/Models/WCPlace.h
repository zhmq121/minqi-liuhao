//
//  WCPlace.h
//  WhereIsMyCar
//
//  Created by Hao Liu on 9/4/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

extern NSString *const WCPlaceTypeCar;
extern NSString *const WCPlaceTypeParked;

@interface WCPlace : NSObject <MKAnnotation, NSCopying>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
@property (strong) NSString *type;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate withType:(NSString *)type;

- (void)setTitle:(NSString *)title;
- (void)setSubtitle:(NSString *)subtitle;

@end
