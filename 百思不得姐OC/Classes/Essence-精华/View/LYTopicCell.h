//
//  LYTopicCell.h
//  百思不得姐OC
//
//  Created by linyi on 16/7/13.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYTopic;

@interface LYTopicCell : UITableViewCell

@property (nonatomic, strong) LYTopic *topic;

@property (nonatomic, assign) BOOL stopPlay;
@property (nonatomic, assign) BOOL pausePlay;

@end
