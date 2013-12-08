//
//  WCMapView.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 8/28/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCMapView.h"
#import "WCPlace.h"
#import "WCIconAnnotationView.h"
#import "WCConfigManager.h"
#import <AddressBook/AddressBook.h>

@interface WCMapView()

@property (assign) BOOL hasUserLocation;

@end

@implementation WCMapView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {        
        self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.frameWidth, self.frameHeight)];
        self.mapView.showsUserLocation = YES;
        self.mapView.mapType = [[WCConfigManager sharedInstance] mapType];
        self.mapView.rotateEnabled = NO;
        self.mapView.delegate = self;
        [self addSubview:self.mapView];
    }
    
    return self;
}

- (void)dealloc
{
    // Forcing map to switch its types to help release memory
    self.mapView.mapType = (self.mapView.mapType == MKMapTypeStandard ? MKMapTypeHybrid : MKMapTypeStandard);
    self.mapView.showsUserLocation = NO;
    self.mapView.delegate = nil;
    [self.mapView removeFromSuperview];
    self.mapView = nil;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    WCPlace *place = (WCPlace *)annotation;
    WCIconAnnotationView *iconAnnotationView = (WCIconAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:WCIconAnnotationViewReuseIdentifier];
    
    if (iconAnnotationView)
    {
        return iconAnnotationView;
    }
    else
    {
        iconAnnotationView = [[WCIconAnnotationView alloc] initWithAnnotation:place reuseIdentifier:WCIconAnnotationViewReuseIdentifier];
        iconAnnotationView.canShowCallout = YES;
        UIButton *rightCalloutButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightCalloutButton addTarget:self action:@selector(launchNavigationInMapApp:) forControlEvents:UIControlEventTouchUpInside];
        
        iconAnnotationView.rightCalloutAccessoryView = rightCalloutButton;
    }
    
    return iconAnnotationView;
}

- (void)launchNavigationInMapApp:(id)sender
{
    for (id<MKAnnotation> annotation in self.mapView.annotations)
    {
        if (annotation != self.mapView.userLocation)
        {
            WCPlace *place = (WCPlace *)annotation;
            
            NSDictionary *addressDict = @{(NSString *)kABPersonAddressStreetKey:place.subtitle};
            // Create an MKMapItem to pass to the Maps app
            MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:place.coordinate addressDictionary:addressDict];
            MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
            [mapItem setName:NSLocalizedString(@"My car location", @"")];
            // Pass the map item to the Maps app
            [mapItem openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking}];
            break;
        }
    }
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    for(MKAnnotationView *annotationView in views)
    {
        if(annotationView.annotation == self.mapView.userLocation)
        {

        }
        else
        {
            // Check if current annotation is inside visible map rect
            MKMapPoint point =  MKMapPointForCoordinate(annotationView.annotation.coordinate);
            if (!MKMapRectContainsPoint(self.mapView.visibleMapRect, point)) {
                continue;
            }
            
            CGRect endFrame = annotationView.frame;
            
            // Move annotation out of view
            annotationView.frame = CGRectMake(annotationView.frame.origin.x,
                                              annotationView.frame.origin.y - self.mapView.frame.size.height,
                                              annotationView.frame.size.width,
                                              annotationView.frame.size.height);
            
            // Animate drop
            [UIView animateWithDuration:0.5
                                  delay:0.04*[views indexOfObject:annotationView]
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 
                                 annotationView.frame = endFrame;
                                 
                                 // Animate squash
                             }completion:^(BOOL finished){
                                 if (finished) {
                                     [UIView animateWithDuration:0.05 animations:^{
                                         annotationView.transform = CGAffineTransformMakeScale(1.0, 0.8);
                                         
                                     }completion:^(BOOL finished){
                                         if (finished) {
                                             [UIView animateWithDuration:0.1 animations:^{
                                                 annotationView.transform = CGAffineTransformIdentity;
                                             }];
                                         }
                                     }];
                                 }
                             }];
        }
    }
}


- (void)setCenterToCurrentLocationForced:(BOOL)forced
{
    if(forced == YES || (self.hasUserLocation == NO && self.mapView.userLocation.location != nil))
    {
        MKCoordinateRegion viewRegion =  MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 2000, 2000);
        [self.mapView setRegion:viewRegion animated:NO];
        self.hasUserLocation = YES;
    }
}

- (void)removeAllPinsButUserLocation
{
    id userLocation = [self.mapView userLocation];
    NSMutableArray *pins = [[NSMutableArray alloc] initWithArray:[self.mapView annotations]];
    if ( userLocation != nil ) {
        [pins removeObject:userLocation]; // avoid removing user location off the map
    }
    
    [self.mapView removeAnnotations:pins];
    pins = nil;
}

- (void)mapView:(MKMapView *)mv didUpdateUserLocation:(MKUserLocation *)userLocation
{
    [self setCenterToCurrentLocationForced:NO];
    if (self.delegate && [self.delegate respondsToSelector:@selector(userLocationUpdated)])
    {
        [self.delegate userLocationUpdated];
    }
}

@end
