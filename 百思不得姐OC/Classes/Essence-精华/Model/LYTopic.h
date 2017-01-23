//
//  LYTopic.h
//  百思不得姐OC
//
//  Created by linyi on 16/7/11.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LYTopicType)
{
    LYTopicTypeAll = 1,
    LYTopicTypeVideo = 41,
    LYTopicTypeVoice = 31,
    LYTopicTypeWord = 29,
    LYTopicTypePicture = 10
};

@class LYComment;

@interface LYTopic : NSObject

/** 帖子ID */
@property (nonatomic, copy) NSString *ID;
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 存放最热评论的数组 */
@property (nonatomic, strong) LYComment *topCmt;
/** 帖子类型 */
@property (nonatomic, assign) LYTopicType type;
/** 图片宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片高度 */
@property (nonatomic, assign) CGFloat height;
/** 是否为GIF动图 */
@property (nonatomic, assign) BOOL is_gif;
/** 小图 */
@property (nonatomic, copy) NSString *small_image;
/** 中图 */
@property (nonatomic, copy) NSString *middle_image;
/** 大图 */
@property (nonatomic, copy) NSString *large_image;
/** 声音长度 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频长度 */
@property (nonatomic, assign) NSInteger videotime;
/** 播放量 */
@property (nonatomic, assign) NSInteger playcount;
/** 视频Url */
@property (nonatomic, copy) NSString *videouri;
/** 音频Url */
@property (nonatomic, copy) NSString *voiceuri;


/***** 额外增加的属性 *****/
/** 帖子高度 */
@property (nonatomic, assign) CGFloat topicHeight;
/** 中间控件的frame */
@property (nonatomic, assign) CGRect contentFrame;
/** 是否为大图 */
@property (nonatomic, assign) BOOL isBigPicture;

@end
