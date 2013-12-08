//
//  WCFavoritesManager.h
//  WhereIsMyCar
//
//  Created by Hao Liu on 9/8/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCFavorite.h"

@interface WCFavoritesManager : NSObject

@property (strong, nonatomic, readonly) NSMutableArray *favorites;

- (void)addFavorite:(WCFavorite *)aFavorite;
- (void)deleteFavorite:(WCFavorite *)aFavorite;
- (void)saveFavoritesToDisk;

+ (WCFavoritesManager *)sharedInstance;
@end
