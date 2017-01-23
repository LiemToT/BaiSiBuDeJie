//
//  LYTopicCell.m
//  百思不得姐OC
//
//  Created by linyi on 16/7/13.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYTopicCell.h"
#import "LYTopic.h"
#import <UIImageView+WebCache.h>
#import "LYComment.h"
#import "LYUser.h"
#import "XMGTopicPictureView.h"
#import "XMGTopicVoiceView.h"
#import "XMGTopicVideoView.h"
#import "VideoPlayView.h"

@interface LYTopicCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 最热评论-整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
/** 最热评论-文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;

/** 图片 */
@property (nonatomic, weak) XMGTopicPictureView *pictureView;
/** 视频 */
@property (nonatomic, weak) XMGTopicVideoView *videoView;
/** 声音 */
@property (nonatomic, weak) XMGTopicVoiceView *voiceView;

@end

@implementation LYTopicCell
#pragma mark - 懒加载
- (XMGTopicPictureView *)pictureView
{
    if (!_pictureView) {
        XMGTopicPictureView *pictureView = [XMGTopicPictureView ly_viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    
    return _pictureView;
}

- (XMGTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        XMGTopicVoiceView *voiceView = [XMGTopicVoiceView ly_viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    
    return _voiceView;
}

- (XMGTopicVideoView *)videoView
{
    if (!_videoView) {
        XMGTopicVideoView *videoView = [XMGTopicVideoView ly_viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    
    return _videoView;
}

- (void)setStopPlay:(BOOL)stopPlay
{
    //_stopPlay = stopPlay;
    
    if (stopPlay) {
        if (_videoView) {
            [_videoView.playView resetPlayView];
        }
        
        if (_voiceView) {
            [_voiceView.playView resetPlayView];
        }
    }
}

- (void)setPausePlay:(BOOL)pausePlay
{
    //_pausePlay = pausePlay;
    
    if (pausePlay) {
        if (_videoView) {
            [_videoView.playView suspendPlayVideo];
        }
        
        if (_voiceView) {
            [_voiceView.playView suspendPlayVideo];
        }
    }
}

#pragma mark - 初始化
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (IBAction)more:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"收藏");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive
                                            handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"举报");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }]];
    
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)setTopic:(LYTopic *)topic
{
    _topic = topic;
    
    [self.profileImageView setHeaderWithUrl:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;
    // 设置底部工具条的数字
    [self setupButtonTitle:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton number:topic.comment placeholder:@"评论"];
    
    // 设置最热评论
    
    if (topic.topCmt) {
        self.topCmtView.hidden = false;
        
        NSString *username = topic.topCmt.user.username;
        NSString *content = topic.topCmt.content;
        
        if (topic.topCmt.voiceuri.length) {
            content = @"[语音评论]";
        }
        
        self.topCmtLabel.text = [NSString stringWithFormat:@"%@: %@", username, content];
    } else {
        self.topCmtView.hidden = true;
    }
    
    // 设置中间控件内容
    switch (topic.type) {
        case LYTopicTypePicture:
            self.pictureView.hidden = false;
            self.pictureView.frame = topic.contentFrame;
            self.pictureView.topic = topic;
            
            self.voiceView.hidden = true;
            self.videoView.hidden = true;
            break;
    
        case LYTopicTypeWord:
            self.pictureView.hidden = true;
            self.voiceView.hidden = true;
            self.videoView.hidden = true;
            break;
            
        case LYTopicTypeVoice:
            self.voiceView.hidden = false;
            self.voiceView.frame = topic.contentFrame;
            self.voiceView.topic = topic;
            
            self.pictureView.hidden = true;
            self.videoView.hidden = true;
            break;
            
        case LYTopicTypeVideo:
            self.videoView.hidden = false;
            self.videoView.frame = topic.contentFrame;
            self.videoView.topic = topic;
            
            self.pictureView.hidden = true;
            self.voiceView.hidden = true;
            break;
            
        default:
            break;
    }
}

/**
 * 设置工具条按钮的文字
 */
- (void)setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= LYMargin;
    frame.origin.y += LYMargin;
    
    [super setFrame:frame];
}

@end









