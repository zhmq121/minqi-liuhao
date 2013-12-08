//
//  WCFavorite.h
//  WhereIsMyCar
//
//  Created by Hao Liu on 9/8/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

@interface WCFavorite : NSObject

@property (assign) CGFloat lat;
@property (assign) CGFloat lng;
@property (strong) NSString *address;
@property (strong) NSDate *date;
@property (strong) NSString *note;

@end
