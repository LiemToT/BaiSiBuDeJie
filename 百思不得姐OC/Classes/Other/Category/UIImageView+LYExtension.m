//
//  UIImageView+LYExtension.m
//  百思不得姐OC
//
//  Created by linyi on 16/7/25.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "UIImageView+LYExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (LYExtension)

- (void)setHeaderWithUrl:(NSString *)url
{
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage circleImageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        
        self.image = [image circleImage];
    }];
}

@end
