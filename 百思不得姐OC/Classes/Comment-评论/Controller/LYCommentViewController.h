//
//  LYCommentViewController.h
//  百思不得姐OC
//
//  Created by linyi on 16/7/25.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYTopic;

@interface LYCommentViewController : UIViewController
/** 帖子模型 */
@property (nonatomic, strong) LYTopic *topic;
@end
