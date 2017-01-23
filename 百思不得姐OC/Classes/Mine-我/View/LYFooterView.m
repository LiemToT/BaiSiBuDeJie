//
//  LYFooterView.m
//  百思不得姐OC
//
//  Created by linyi on 16/7/7.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYFooterView.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "LYMeSquare.h"
#import "LYMeSquareButton.h"
#import "LYWebViewController.h"
#import <SafariServices/SafariServices.h>

@implementation LYFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
            [responseObject writeToFile:@"/Users/linyi/Desktop/Me.plist" atomically:YES];
            NSArray *squares = [LYMeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            [self createSquareWithArray:[self handleSquares:squares]];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"请求失败----%@", error.description);
        }];
    }
    return self;
}

//处理重复数据
- (NSArray *)handleSquares:(NSArray *)squares
{
    NSMutableArray *squaresNew = [NSMutableArray arrayWithArray:squares];
    NSMutableArray *listArray = [NSMutableArray array];
    for (LYMeSquare *square in squares) {
        if (![listArray containsObject:square.name]) {
            [listArray addObject:square.name];
        } else {
            [squaresNew removeObject:square];
        }
    }
    return squaresNew;
}

- (void)createSquareWithArray:(NSArray *)squares
{
    int maxColsSquare = 4;
    
    CGFloat buttonW = self.ly_width / maxColsSquare;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i < squares.count; i++) {
        LYMeSquareButton *button = [LYMeSquareButton buttonWithType:UIButtonTypeCustom];
        button.square = squares[i];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        button.ly_x = (i % maxColsSquare) * buttonW;
        button.ly_y = (i / maxColsSquare) * buttonH;
        button.ly_width = i % maxColsSquare == 3 ? buttonW : buttonW - 1;
        button.ly_height = buttonH - 1;
    }
    
    self.ly_height = self.subviews.lastObject.ly_bottom;
    
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
    [tableView reloadData];
}

- (void)click:(LYMeSquareButton *)squareButton
{
    NSString *url = squareButton.square.url;
    
    if ([url hasPrefix:@"http"]) {
        NSLog(@"用WebView加载网页");
        UITabBarController *tabBar = (UITabBarController *)self.window.rootViewController;
        UINavigationController *nav = tabBar.selectedViewController;
        
        //自定义浏览器(无进度条,需自定义)
//        LYWebViewController *webView = [[LYWebViewController alloc] init];
//        webView.url = url;
//        webView.navigationItem.title = squareButton.square.name;
//        [nav pushViewController:webView animated:YES];
        //苹果自带浏览器(自带进度条)
        SFSafariViewController *webView = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
        [nav presentViewController:webView animated:YES completion:nil];
    } else if ([url hasPrefix:@"mod"]) {
        NSLog(@"内部打开模块");
    }
}

@end
