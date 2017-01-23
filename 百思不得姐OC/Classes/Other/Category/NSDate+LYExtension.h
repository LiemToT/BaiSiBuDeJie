//
//  NSDate+LYExtension.h
//  百思不得姐OC
//
//  Created by linyi on 16/7/16.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LYExtension)

- (NSDateComponents *)intervalToDate:(NSDate *)date;
- (NSDateComponents *)intervalToNow;

- (BOOL)isThisYear;
- (BOOL)isToday;
- (BOOL)isYesterday;

@end
