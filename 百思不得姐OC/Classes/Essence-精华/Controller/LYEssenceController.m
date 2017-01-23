//
//  LYEssenceController.m
//  百思不得姐OC
//
//  Created by linyi on 16/6/28.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYEssenceController.h"
#import "LYAllViewController.h"
#import "LYVideoViewController.h"
#import "LYVoiceViewController.h"
#import "LYPictureViewController.h"
#import "LYWordViewController.h"
#import "LYTagViewController.h"

@interface LYEssenceController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIButton *selectedButton;
@property (nonatomic, weak) UIView *indicatorView;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *titleView;

@end

@implementation LYEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = LYNormalBgColor;
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    [self setupChildViewController];
    [self setupNavi];
    [self setupScrollView];
    [self setupTitleView];
    [self addChildVCView];
}

- (void)setupChildViewController
{
    LYAllViewController *allVC = [[LYAllViewController alloc] init];
    [self addChildViewController:allVC];
    
    LYVideoViewController *videoVC = [[LYVideoViewController alloc] init];
    [self addChildViewController:videoVC];
    
    LYVoiceViewController *voiceVC = [[LYVoiceViewController alloc] init];
    [self addChildViewController:voiceVC];
    
    LYPictureViewController *pictureVC = [[LYPictureViewController alloc] init];
    [self addChildViewController:pictureVC];
    
    LYWordViewController *wordVC = [[LYWordViewController alloc] init];
    [self addChildViewController:wordVC];
}

- (void)addChildVCView
{
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.ly_width;
    
    UITableView *tableView = (UITableView *)self.childViewControllers[index].view;
    [self.scrollView addSubview:tableView];
    
    tableView.frame = self.scrollView.bounds;
}

- (void)setupScrollView
{
    self.automaticallyAdjustsScrollViewInsets = false;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.pagingEnabled = true;
    scrollView.bounces = false;
    scrollView.showsVerticalScrollIndicator = false;
    scrollView.showsHorizontalScrollIndicator = false;
    [self.view addSubview:scrollView];
    
    self.scrollView = scrollView;
    self.scrollView.delegate = self;
    
    NSUInteger count = self.childViewControllers.count;
    scrollView.contentSize = CGSizeMake(count * scrollView.ly_width, 0);
}

- (void)setupTitleView
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.ly_width, 35)];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    NSArray *titleArray = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger buttonCount = titleArray.count;
    
    CGFloat buttonW = self.view.ly_width / buttonCount;
    CGFloat buttonH = titleView.ly_height;
    
    for (NSUInteger i = 0; i < buttonCount; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleView addSubview:titleButton];
        titleButton.tag = i;
        
        [titleButton setTitle:titleArray[i] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        if (i == 0) {
            titleButton.selected = true;
            self.selectedButton = titleButton;
        }
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        titleButton.frame = CGRectMake(i * buttonW, 0, buttonW, buttonH);
    }
    
    UIView *indicatorView = [[UIView alloc] init];
    //获取最后一个Button
    UIButton *titleButton = titleView.subviews.lastObject;
    indicatorView.backgroundColor = [titleButton titleColorForState:UIControlStateSelected];
    indicatorView.ly_height = 1;
    [self.selectedButton.titleLabel sizeToFit];
    indicatorView.ly_width = self.selectedButton.titleLabel.ly_width + 10;
    indicatorView.ly_y = titleView.ly_height - 3;
    indicatorView.ly_centerX = self.selectedButton.ly_centerX;
    [titleView addSubview:indicatorView];
    self.indicatorView = indicatorView;
}

- (void)setupNavi
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}

- (void)tagClick {
    LYTagViewController *tagVC = [[LYTagViewController alloc] init];
    [self.navigationController pushViewController:tagVC animated:YES];
}

- (void)titleClick:(UIButton *)titleButton
{
    self.selectedButton.selected = NO;
    titleButton.selected = YES;
    self.selectedButton = titleButton;
    
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.indicatorView.ly_centerX = titleButton.ly_centerX;
    }];
    
    CGPoint contentOffSet = self.scrollView.contentOffset;
    contentOffSet.x = titleButton.tag * self.scrollView.ly_width;
    [self.scrollView setContentOffset:contentOffSet animated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kPausePlayVideoNotification object:nil];
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildVCView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger index = scrollView.contentOffset.x / scrollView.ly_width;
    UIButton *titleButton = self.titleView.subviews[index];
    [self titleClick:titleButton];
    
    [self addChildVCView];
}

@end
















