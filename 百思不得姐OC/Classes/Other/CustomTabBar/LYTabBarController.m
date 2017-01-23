//
//  LYTabBarController.m
//  百思不得姐OC
//
//  Created by linyi on 16/6/27.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYTabBarController.h"
#import "LYTabBar.h"
#import "LYEssenceController.h"
#import "LYFriendTrendsController.h"
#import "LYMineController.h"
#import "LYNewController.h"
#import "LYNavigationController.h"

@interface LYTabBarController ()

@end

@implementation LYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *attrc = [NSMutableDictionary dictionary];
    attrc[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [[UITabBarItem appearance] setTitleTextAttributes:attrc forState:UIControlStateSelected];
    
    [self setUpNewChildViewController:[[LYNavigationController alloc] initWithRootViewController:[[LYEssenceController alloc] init]] title:@"精华" imageName:@"tabBar_essence_icon" selectedImageName:@"tabBar_essence_click_icon"];
    [self setUpNewChildViewController:[[LYNavigationController alloc] initWithRootViewController:[[LYNewController alloc] init]] title:@"新帖" imageName:@"tabBar_new_icon" selectedImageName:@"tabBar_new_click_icon"];
    [self setUpNewChildViewController:[[LYNavigationController alloc] initWithRootViewController:[[LYFriendTrendsController alloc] init]] title:@"关注" imageName:@"tabBar_friendTrends_icon" selectedImageName:@"tabBar_friendTrends_click_icon"];
    [self setUpNewChildViewController:[[LYNavigationController alloc] initWithRootViewController:[[LYMineController alloc] init]] title:@"我" imageName:@"tabBar_me_icon" selectedImageName:@"tabBar_me_click_icon"];
    
    [self setValue:[[LYTabBar alloc] init] forKey:@"tabBar"];
}

/**
 *  添加子控制器接口
 *
 *  @param controller             添加的子控制器
 *  @param title                   标题
 *  @param imageName              图片名字
 *  @param selectedImageName    选中图片名字
 */

- (void)setUpNewChildViewController:(UIViewController *)controller title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:imageName];
    controller.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    controller.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:controller];
}


@end
