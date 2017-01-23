//
//  XMGTopicVideoView.m
//  3期-百思不得姐
//
//  Created by xiaomage on 15/9/17.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "XMGTopicVideoView.h"
#import <UIImageView+WebCache.h>
#import "LYTopic.h"
#import "VideoPlayView.h"
#import "LYTopicCell.h"

@interface XMGTopicVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;

@end

@implementation XMGTopicVideoView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoCellDidDismiss) name:UIVideoCellDidHideNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setTopic:(LYTopic *)topic
{
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    
    NSInteger minute = self.topic.videotime / 60;
    NSInteger second = self.topic.videotime % 60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", self.topic.playcount];
}

- (IBAction)playVideo:(id)sender {
    LYTopicCell *selectedCell = (LYTopicCell *)[[self superview] superview];
    UITableView *notiTableView = (UITableView *)selectedCell.superview.superview;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kPlayVideoCellNotification object:notiTableView userInfo:@{@"PlayCell" : selectedCell}];
    
    [self.playView resetPlayView];
    self.playView = [VideoPlayView videoPlayView];
    self.playView.frame = self.imageView.frame;
    self.playView.playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.topic.videouri]];
    [self addSubview:self.playView];
}

- (void)videoCellDidDismiss {
    if (self.playView) {
        [self.playView resetPlayView];
    }
}

@end








