//
//  NSDate+LYExtension.m
//  百思不得姐OC
//
//  Created by linyi on 16/7/16.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "NSDate+LYExtension.h"

@implementation NSDate (LYExtension)

- (NSDateComponents *)intervalToDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar ly_Calendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth |
                           NSCalendarUnitDay | NSCalendarUnitHour |
                           NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:date options:0];
}

- (NSDateComponents *)intervalToNow
{
    return [self intervalToDate:[NSDate date]];
}

- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar ly_Calendar];
    
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return selfYear == nowYear;
}

- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar ly_Calendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *selfComps = [calendar components:unit fromDate:self];
    NSDateComponents *nowComps = [calendar components:unit fromDate:[NSDate date]];
    
    return selfComps.year == nowComps.year && selfComps.month == nowComps.month
    && selfComps.day == nowComps.day;
}

- (BOOL)isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    
    NSString *selfString = [fmt stringFromDate:self];
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    
    NSDate *selfDate = [fmt dateFromString:selfString];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    NSCalendar *calendar = [NSCalendar ly_Calendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateCmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return dateCmps.year == 0 && dateCmps.month == 0 && dateCmps.day == 1;
}

@end








