//
//  XMGTopicPictureView.m
//  3期-百思不得姐
//
//  Created by xiaomage on 15/9/16.
//  Copyright (c) 2015年 xiaomage. All rights reserved.
//

#import "XMGTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "LYTopic.h"
#import <DALabeledCircularProgressView.h>
#import "LYSeeBigViewController.h"

@interface XMGTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@end

@implementation XMGTopicPictureView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    
    self.imageView.userInteractionEnabled = true;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setBig)]];
}

- (void)setBig {
    LYSeeBigViewController *big = [[LYSeeBigViewController alloc] init];
    big.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:big animated:true completion:nil];
}

- (void)setTopic:(LYTopic *)topic
{
    _topic = topic;
    
    WeakSelf
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        weakSelf.progressView.progress = progress;
        weakSelf.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
        weakSelf.progressView.hidden = false;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.progressView.hidden = true;
    }];
    
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    
    if (self.topic.is_gif) {
        self.gifView.hidden = false;
        self.seeBigPictureButton.hidden = true;
    } else {
        self.gifView.hidden = true;
        
        if (self.topic.isBigPicture) {
            self.seeBigPictureButton.hidden = false;
            self.imageView.contentMode = UIViewContentModeTop;
            self.imageView.clipsToBounds = true;
        } else {
            self.seeBigPictureButton.hidden = true;
        }
    }
    
}

@end
