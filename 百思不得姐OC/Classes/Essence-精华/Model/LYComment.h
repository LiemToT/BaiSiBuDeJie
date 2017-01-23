//
//  LYComment.h
//  百思不得姐OC
//
//  Created by linyi on 16/7/17.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYUser;

@interface LYComment : NSObject
/** id */
@property (nonatomic, copy) NSString *ID;

/** 文字内容 */
@property (nonatomic, copy) NSString *content;

/** 用户 */
@property (nonatomic, strong) LYUser *user;

/** 点赞数 */
@property (nonatomic, assign) NSInteger like_count;

/** 语音文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;

/** 语音文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
@end
