//
//  LYMineController.m
//  百思不得姐OC
//
//  Created by linyi on 16/6/28.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYMineController.h"

@interface LYMineController ()

@end

@implementation LYMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = LYNormalBgColor;
    
    self.navigationItem.title = @"我的";
    
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [settingButton setImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    [settingButton sizeToFit];
    [settingButton addTarget:self action:@selector(settingClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *settingBarItem = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
    
    UIButton *moonButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moonButton setImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [moonButton setImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    [moonButton sizeToFit];
    [moonButton addTarget:self action:@selector(moonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *moonBarItem = [[UIBarButtonItem alloc] initWithCustomView:moonButton];
    
    self.navigationItem.rightBarButtonItems = @[settingBarItem, moonBarItem];
}

- (void)settingClick {
    LYLogFunc;
}

- (void)moonClick {
    LYLogFunc;
}

@end
