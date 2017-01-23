//
//  NSCalendar+LYExtension.m
//  百思不得姐OC
//
//  Created by linyi on 16/7/16.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "NSCalendar+LYExtension.h"

@implementation NSCalendar (LYExtension)

+ (instancetype)ly_Calendar
{
    if (LYIOS(8.0)) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else {
        return [NSCalendar currentCalendar];
    }
}

@end
