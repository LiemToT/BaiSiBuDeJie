//
//  NSString+LYExtension.m
//  百思不得姐OC
//
//  Created by linyi on 16/7/8.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "NSString+LYExtension.h"

@implementation NSString (LYExtension)

- (CGFloat)ly_fileSize
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    float size = 0;
    
    if ([fileManager fileExistsAtPath:self]) {
        NSArray *childerFile = [fileManager subpathsAtPath:self];
        
        for (NSString *childPath in childerFile) {
            NSString *fullPath = [self stringByAppendingPathComponent:childPath];
            
            size += [fileManager attributesOfItemAtPath:fullPath error:nil].fileSize;
        }
    }
    
    return size;
}

- (void)ly_cleanFileCache
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [fileManager removeItemAtPath:self error:nil];
    [fileManager createDirectoryAtPath:self withIntermediateDirectories:false attributes:nil error:nil];
}

@end
