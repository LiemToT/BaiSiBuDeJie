//
//  LYSectionHeaderView.m
//  百思不得姐OC
//
//  Created by linyi on 16/7/27.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYSectionHeaderView.h"

@implementation LYSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.contentView.backgroundColor = LYNormalBgColor;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.ly_x = LYMargin;
    self.textLabel.font = [UIFont systemFontOfSize:15];
}

@end
