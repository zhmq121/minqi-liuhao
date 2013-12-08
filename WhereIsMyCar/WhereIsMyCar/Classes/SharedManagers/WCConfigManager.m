//
//  WCConfigManager.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 10/7/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCConfigManager.h"
#import "WCAppDataStore.h"

NSString const *WCConfigSettingsMapTypeKey = @"WCConfigSettingsMapType";

@implementation WCConfigManager

+ (WCConfigManager *)sharedInstance
{
    static WCConfigManager *sharedManager = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}

- (id)init
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changed) name:NSUserDefaultsDidChangeNotification object:nil];
    
    return self;
}

- (void)changed
{
    NSLog(@"changed");
}

- (void)loadSettings
{
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle) {
        NSLog(@"Could not find Settings.bundle");
        return;
    }
    
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences) {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if(key) {
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
        }
    }
    
    [WCAppDataStore registerDefaults:defaultsToRegister];
    [WCAppDataStore synchronize];
}

- (MKMapType)mapType
{
    NSString *const mapTypeKey = @"multiValueMapType";
    
    NSInteger mapTypeCode = 0;
    if ([WCAppDataStore objectForKey:mapTypeKey] == nil)
    {
        [self loadSettings];
    }
    mapTypeCode = [WCAppDataStore integerForKey:mapTypeKey];
    
    if (mapTypeCode == 0)
    {
        return MKMapTypeStandard;
    }
    else if (mapTypeCode == 1)
    {
        return MKMapTypeHybrid;
    }
    else
    {
        return MKMapTypeSatellite;
    }
}

- (NSInteger)notifyMeBefore
{
    NSString *const notifyMeBeforeKey = @"multiValueNotifyMeBefore";
    
    NSInteger notifyMeBefore = 0;
    if ([WCAppDataStore objectForKey:notifyMeBeforeKey] == nil)
    {
        [self loadSettings];
        
    }
    notifyMeBefore = [WCAppDataStore integerForKey:notifyMeBeforeKey];
    
    return notifyMeBefore;
}

@end
