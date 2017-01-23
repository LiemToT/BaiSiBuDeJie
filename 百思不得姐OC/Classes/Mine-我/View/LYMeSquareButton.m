//
//  LYMeSquareButton.m
//  百思不得姐OC
//
//  Created by linyi on 16/7/7.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYMeSquareButton.h"
#import "UIButton+WebCache.h"

@implementation LYMeSquareButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.ly_y = self.ly_height * 0.2;
    self.imageView.ly_height = self.ly_height * 0.5;
    self.imageView.ly_width = self.imageView.ly_height;
    self.imageView.ly_centerX = self.ly_width * 0.5;
    
    self.titleLabel.ly_y = self.imageView.ly_bottom;
    self.titleLabel.ly_x = 0;
    self.titleLabel.ly_width = self.ly_width;
    self.titleLabel.ly_height = self.ly_height - self.titleLabel.ly_y;
}

- (void)setSquare:(LYMeSquare *)square
{
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    NSLog(@"square.icon");
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end
