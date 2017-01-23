//
//  LYUser.h
//  百思不得姐OC
//
//  Created by linyi on 16/7/17.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYUser : NSObject

/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

@end
