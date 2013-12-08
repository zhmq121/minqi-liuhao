//
//  WCGeoManager.h
//  WhereIsMyCar
//
//  Created by Hao Liu on 9/4/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

@interface WCGeoManager : NSObject

+ (WCGeoManager *)sharedInstance;

- (void)getAddress:(CLLocationCoordinate2D)coordinate addCompletionHandler:(void (^)(NSString *address))completionHandler errorHandler:(void (^)(NSError *error))errorHandler;

@end
