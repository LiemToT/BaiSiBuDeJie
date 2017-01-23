//
//  UIBarButtonItem+LYExtensions.m
//  百思不得姐OC
//
//  Created by linyi on 7/3/16.
//  Copyright © 2016 linyi. All rights reserved.
//

#import "UIBarButtonItem+LYExtensions.h"

@implementation UIBarButtonItem (LYExtensions)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action {
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [tagButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [tagButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [tagButton sizeToFit];
    
    return [[UIBarButtonItem alloc] initWithCustomView:tagButton];
}

@end
