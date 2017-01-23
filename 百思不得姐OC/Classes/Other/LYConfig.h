//
//  LYConfig.h
//  百思不得姐OC
//
//  Created by linyi on 16/7/6.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CONFIG_EXTERN_NSSTRING extern NSString *const
#define CONFIG_EXTERN_CGFLOAT extern CGFloat const
#define CONFIG_KEY_NSSTRING NSString *const
#define CONFIG_KEY_CGFLOAT CGFloat const

CONFIG_EXTERN_CGFLOAT LYMargin;
CONFIG_EXTERN_NSSTRING LYRequestURL;
CONFIG_EXTERN_NSSTRING UIVideoCellDidHideNotification;
CONFIG_EXTERN_NSSTRING kPlayVideoCellNotification;
CONFIG_EXTERN_NSSTRING kPausePlayVideoNotification;