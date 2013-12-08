//
//  WCGeoManager.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 9/4/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCGeoManager.h"



@implementation WCGeoManager

+ (WCGeoManager *)sharedInstance
{
    static WCGeoManager *sharedManager = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

- (void)getAddress:(CLLocationCoordinate2D)coordinate addCompletionHandler:(void (^)(NSString *address))completionHandler errorHandler:(void (^)(NSError *error))errorHandler
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *newLocation = [[CLLocation alloc]initWithLatitude:coordinate.latitude
                                                        longitude:coordinate.longitude];
    
    [geocoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       if (error) {
                           errorHandler(error);
                           NSLog(@"Geocode failed with error: %@", error);
                       }
                       
                       if (placemarks && placemarks.count > 0)
                       {
                           CLPlacemark *placemark = placemarks[0];
                           NSDictionary *addressDictionary = placemark.addressDictionary;
                           
                           NSString *street = [addressDictionary objectForKey:@"Street"];
                           NSString *city = [addressDictionary objectForKey:@"City"];
                           NSString *state = [addressDictionary objectForKey:@"State"];
                           NSString *zip = [addressDictionary objectForKey:@"ZIP"];
                           NSString *country = [addressDictionary objectForKey:@"Country"];
                           
                           NSString *result = [NSString stringWithFormat:@"%@ \n%@, %@ %@ \n%@", street, city, state, zip, country];
                           completionHandler(result);
                       }
                       
                   }];
}

@end
