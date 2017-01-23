//
//  UIBarButtonItem+LYExtensions.h
//  百思不得姐OC
//
//  Created by linyi on 7/3/16.
//  Copyright © 2016 linyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LYExtensions)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
