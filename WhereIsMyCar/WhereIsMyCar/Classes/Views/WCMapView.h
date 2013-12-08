//
//  WCMapView.h
//  WhereIsMyCar
//
//  Created by Hao Liu on 8/28/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import <MapKit/MapKit.h>

@protocol WCMapViewDelegate <NSObject>

@optional
- (void)userLocationUpdated;

@end

@interface WCMapView : UIView <MKMapViewDelegate>

@property (strong) MKMapView *mapView;

@property (assign) id<WCMapViewDelegate> delegate;
- (void)setCenterToCurrentLocationForced:(BOOL)forced;
- (void)removeAllPinsButUserLocation;

@end
