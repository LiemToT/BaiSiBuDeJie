//
//  LYTopic.m
//  百思不得姐OC
//
//  Created by linyi on 16/7/11.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYTopic.h"
#import <MJExtension.h>
#import "LYComment.h"
#import "LYUser.h"

@implementation LYTopic

#pragma mark -
static NSDateFormatter *formatter;

+ (void)initialize
{
    formatter = [[NSDateFormatter alloc] init];
}

- (NSString *)created_at
{
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *createDate = [formatter dateFromString:_created_at];
    
    if (createDate.isThisYear) {
        if (createDate.isToday) {
            NSDateComponents *dateComps = [createDate intervalToNow];
            
            if (dateComps.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前", dateComps.hour];
            } else if (dateComps.minute >= 1) {
                return [NSString stringWithFormat:@"%zd分钟前", dateComps.minute];
            } else {
                return @"刚刚";
            }
        } else if (createDate.isYesterday) {
            formatter.dateFormat = @"昨天 HH:mm:ss";
            return [formatter stringFromDate:createDate];
        } else {
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return [formatter stringFromDate:createDate];
        }
    } else {
        return _created_at;
    }
}

- (CGFloat)topicHeight
{
    if (_topicHeight) return _topicHeight;
    
    //1.头像高度
    _topicHeight = 45 + LYMargin;
    
    //2.文字高度
    CGFloat textMaxW = [UIScreen mainScreen].bounds.size.width - 2 * LYMargin;
    CGSize textConsSize = CGSizeMake(textMaxW, MAXFLOAT);
    
    CGSize textSize = [self.text boundingRectWithSize:textConsSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0]} context:nil].size;
    _topicHeight += textSize.height + LYMargin;
    
    //3.中间控件高度
    if (_type != LYTopicTypeWord) {
        CGFloat contentH = textMaxW * _height / _width;
        if (contentH >= [UIScreen mainScreen].bounds.size.height) {
            contentH = 200;
            self.isBigPicture = true;
        } else {
            self.isBigPicture = false;
        }
        
        self.contentFrame = CGRectMake(LYMargin, _topicHeight, textMaxW, contentH);
        
        _topicHeight += contentH + LYMargin;
    }
    
    //4.评论高度
    if (_topCmt) {
        //最热评论--标题
        _topicHeight += 20;
        
        NSString *content = _topCmt.content;
        
        if (_topCmt.voiceuri.length) {
            content = @"[语音评论]";
        }
        
        //最热评论--内容
        NSString *comment = [NSString stringWithFormat:@"%@: %@", _topCmt.user.username, content];
        CGSize textConsSize = CGSizeMake(textMaxW, MAXFLOAT);
        CGSize textSize = [comment boundingRectWithSize:textConsSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size;
        
        _topicHeight += textSize.height + LYMargin;
    }
    
    //5.底部工具栏
    _topicHeight += 35;
    
    return _topicHeight;
}

@end








