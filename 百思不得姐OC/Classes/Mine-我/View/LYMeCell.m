//
//  LYMeCell.m
//  百思不得姐OC
//
//  Created by linyi on 16/7/6.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYMeCell.h"

@implementation LYMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    
    self.imageView.ly_y = LYMargin;
    self.imageView.ly_height = self.contentView.ly_height - 2 * LYMargin;
    self.imageView.ly_width = self.imageView.ly_height;
    
    self.textLabel.ly_x = self.imageView.ly_right + LYMargin;
}

@end
