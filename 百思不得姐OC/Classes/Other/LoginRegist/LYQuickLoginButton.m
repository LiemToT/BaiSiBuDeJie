//
//  LYQuickLoginButton.m
//  百思不得姐OC
//
//  Created by linyi on 7/4/16.
//  Copyright © 2016 linyi. All rights reserved.
//

#import "LYQuickLoginButton.h"

@implementation LYQuickLoginButton

- (void)awakeFromNib
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.ly_y = 0;
    self.imageView.ly_centerX = self.ly_width * 0.5;
    
    self.titleLabel.ly_x = 0;
    self.titleLabel.ly_y = self.imageView.ly_bottom;
    self.titleLabel.ly_width = self.ly_width;
    self.titleLabel.ly_height = self.ly_height - self.imageView.ly_height;
}

@end
