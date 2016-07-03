//
//  LYTabBar.m
//  百思不得姐OC
//
//  Created by linyi on 16/6/28.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYTabBar.h"

@interface LYTabBar ()

@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation LYTabBar

- (UIButton *)publishButton {
    if (!_publishButton) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [publishButton addTarget:self action:@selector(publish) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        _publishButton = publishButton;
    }
    
    return _publishButton;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    int buttonIndex = 0;
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonY = 0;
    
    for (UIView *subview in self.subviews) {
        if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
        
        CGFloat buttonX = buttonIndex * buttonW;
        
        if (buttonIndex > 1) {
            buttonX += buttonW;
        }
        
        subview.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        buttonIndex++;
    }
    
    self.publishButton.frame = CGRectMake(0, 0, buttonW, buttonH);
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}

- (void)publish {
    
}

@end
