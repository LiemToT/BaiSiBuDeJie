//
//  LYTagViewController.m
//  百思不得姐OC
//
//  Created by linyi on 16/7/25.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYTagViewController.h"
#import <AFNetworking.h>
#import "XMGTag.h"
#import <MJExtension.h>
#import "XMGTagCell.h"

@interface LYTagViewController ()

@property (nonatomic, weak) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSArray<XMGTag *> *tagArray;

@end

@implementation LYTagViewController

/** cell的循环利用标识 */
static NSString * const LYTagCellId = @"tag";

#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    
    return _manager;
}

#pragma mark - 初始化

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"推荐标签";
    
    self.tableView.rowHeight = 70.0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = LYNormalBgColor;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGTagCell class]) bundle:nil] forCellReuseIdentifier:LYTagCellId];
    
    [self loadRequest];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
    [self.manager invalidateSessionCancelingTasks:true];
}

- (void)loadRequest
{
    [SVProgressHUD show];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    WeakSelf
    [self.manager GET:LYRequestURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.tagArray = [XMGTag mj_objectArrayWithKeyValuesArray:responseObject];
        [weakSelf.tableView reloadData];
        
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 如果是取消了任务，就不算请求失败，就直接返回
        if (error.code == NSURLErrorCancelled) return;
        
        if (error.code == NSURLErrorTimedOut) {
            // 关闭弹框
            [SVProgressHUD showErrorWithStatus:@"加载标签数据超时，请稍后再试！"];
        } else {
            // 关闭弹框
            [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
        }

    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.tagArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMGTagCell *cell = [tableView dequeueReusableCellWithIdentifier:LYTagCellId];
    
    cell.tagModel = self.tagArray[indexPath.row];
    
    return cell;
}


@end
