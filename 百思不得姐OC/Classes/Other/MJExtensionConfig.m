//
//  MJExtensionConfig.m
//  3期-百思不得姐
//
//  Created by xiaomage on 15/9/17.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "MJExtensionConfig.h"
#import <MJExtension.h>
#import "LYTopic.h"

#import "LYUser.h"
#import "LYComment.h"


@implementation MJExtensionConfig
+ (void)load
{
    [LYTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2",
                 @"large_image" : @"image1",
                 @"topCmt" : @"top_cmt[0]"
                 };
    }];
    
    [LYComment mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID" : @"id"};
    }];
}
@end
