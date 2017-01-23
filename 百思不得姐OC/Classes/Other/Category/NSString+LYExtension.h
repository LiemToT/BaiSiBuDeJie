//
//  NSString+LYExtension.h
//  百思不得姐OC
//
//  Created by linyi on 16/7/8.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LYExtension)

- (CGFloat)ly_fileSize;

/**
 *  清除缓存操作
 *
 *  @return 清除操作完成后返回YES
 */
- (void)ly_cleanFileCache;

@end
