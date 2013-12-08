//
//  WCUtils.m
//  WhereIsMyCar
//
//  Created by Hao Liu on 10/13/13.
//  Copyright (c) 2013 Hao Liu. All rights reserved.
//

#import "WCUtils.h"

NSString *getHourAndMinutePartsFromDate(NSDate *date)
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm"];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    return [NSString stringWithFormat:@"%02d:%02d", hour, minute];
}
