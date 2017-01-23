//
//  LYFriendTrendsController.m
//  百思不得姐OC
//
//  Created by linyi on 16/6/28.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYFriendTrendsController.h"
#import "LYRecommendFollowViewController.h"
#import "LYLoginRegistViewController.h"

@interface LYFriendTrendsController ()

@end

@implementation LYFriendTrendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = LYNormalBgColor;
    
    self.navigationItem.title = @"我的关注";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendClick)];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
}

- (void)friendClick {
    LYRecommendFollowViewController *recommendFollow = [[LYRecommendFollowViewController alloc] init];
    [self.navigationController pushViewController:recommendFollow animated:true];
}

- (IBAction)loginRegist {
    LYLoginRegistViewController *loginRegist = [[LYLoginRegistViewController alloc] init];
    [self presentViewController:loginRegist animated:YES completion:nil];
}
@end
