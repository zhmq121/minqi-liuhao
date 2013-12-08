//
//  WCFavoritesManager.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 9/8/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCFavoritesManager.h"
#import "WCFavorite.h"

@interface WCFavoritesManager()

@property (strong, nonatomic) NSMutableArray *favorites;

@end

@implementation WCFavoritesManager

+ (WCFavoritesManager *)sharedInstance
{
    static WCFavoritesManager *sharedManager = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

- (NSMutableArray *)favorites
{
    if (_favorites == nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *sandboxFilePath = [documentsDirectory stringByAppendingPathComponent:@"favorites.plist"];

        NSMutableArray *favoriteDicts = nil;
        if ([[NSFileManager defaultManager] fileExistsAtPath:sandboxFilePath])
        {
            favoriteDicts = [NSMutableArray arrayWithContentsOfFile:sandboxFilePath];
        }

        _favorites = [[NSMutableArray alloc] init];
        
        if (favoriteDicts != nil)
        {
            for (NSDictionary *dict in favoriteDicts)
            {
                WCFavorite *favorite = [[WCFavorite alloc] init];
                favorite.address = [dict objectForKey:@"address"];
                favorite.lat = [[dict objectForKey:@"lat"] floatValue];
                favorite.lng = [[dict objectForKey:@"lng"] floatValue];
                favorite.date = [dict objectForKey:@"date"];
                favorite.note = [dict objectForKey:@"note"];
                [_favorites addObject:favorite];
            }
        }
    }

    return _favorites;
}

- (void)addFavorite:(WCFavorite *)aFavorite
{
    [self.favorites addObject:aFavorite];
}

- (void)deleteFavorite:(WCFavorite *)aFavorite
{
    
}

- (void)saveFavoritesToDisk
{
    NSMutableArray *favoriteDicts = [[NSMutableArray alloc] init];
    
    for (WCFavorite *favorite in self.favorites)
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

        [dict setObject:[NSString stringWithFormat:@"%f", favorite.lat] forKey:@"lat"];
        [dict setObject:[NSString stringWithFormat:@"%f", favorite.lng] forKey:@"lng"];
        
        if (favorite.address != nil)
            [dict setObject:favorite.address forKey:@"address"];
        
        if (favorite.note != nil)
            [dict setObject:favorite.note forKey:@"note"];
        
        if (favorite.date != nil)
            [dict setObject:favorite.date forKey:@"date"];
        
        [favoriteDicts addObject:dict];
    }
    
    NSLog(@"%@", favoriteDicts);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *sandboxFilePath = [documentsDirectory stringByAppendingPathComponent:@"favorites.plist"];
    NSString *bundleFilePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"favorites.plist"];
    
    NSError *error = nil;
    [[NSFileManager defaultManager] copyItemAtPath:bundleFilePath toPath:sandboxFilePath error:&error];

    if ([favoriteDicts writeToFile:sandboxFilePath atomically:YES])
        NSLog(@"Favorites saved");
}


@end
