//
//  LYFriendTrendsController.m
//  百思不得姐OC
//
//  Created by linyi on 16/6/28.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYFriendTrendsController.h"

@interface LYFriendTrendsController ()

@end

@implementation LYFriendTrendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = LYNormalBgColor;
    
    self.navigationItem.title = @"我的关注";
    
    UIButton *friendsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [friendsButton setImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [friendsButton setImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    [friendsButton sizeToFit];
    [friendsButton addTarget:self action:@selector(friendClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:friendsButton];
}

- (void)friendClick {
    LYLogFunc;
}

@end
