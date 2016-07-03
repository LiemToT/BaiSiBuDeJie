//
//  LYEssenceController.m
//  百思不得姐OC
//
//  Created by linyi on 16/6/28.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYEssenceController.h"

@interface LYEssenceController ()

@end

@implementation LYEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = LYNormalBgColor;
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [tagButton setImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    [tagButton sizeToFit];
    [tagButton addTarget:self action:@selector(tagClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tagButton];
}

- (void)tagClick {
    LYLogFunc;
}
@end
