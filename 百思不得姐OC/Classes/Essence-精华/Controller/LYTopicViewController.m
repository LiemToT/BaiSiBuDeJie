//
//  LYTopicViewController.m
//  百思不得姐OC
//
//  Created by linyi on 16/7/10.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYTopicViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "LYRefreshHeader.h"
#import "LYRefreshFooter.h"
#import "LYTopicCell.h"
#import "LYNewController.h"
#import "LYCommentViewController.h"

@interface LYTopicViewController () 

@property (nonatomic, strong) NSMutableArray<LYTopic *> *topics;
@property (nonatomic, copy) NSString *maxtime;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) LYTopicCell *playVideoCellSelected;
@property (nonatomic, strong) NSString *lastType;


- (NSString *)aParam;
@end

@implementation LYTopicViewController

- (LYTopicType)type
{
    return 0;
}

static NSString * const TopicCell = @"TopicCell";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoCellSetting:) name:kPlayVideoCellNotification object:self.tableView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pausePlayVideo) name:kPausePlayVideoNotification object:nil];
    
    [self setupTable];
    [self setupRefresh];
}

- (void)setupTable
{
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = LYNormalBgColor;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYTopicCell class])
                                               bundle:nil] forCellReuseIdentifier:TopicCell];
    self.tableView.rowHeight = 250;
}

- (void)setupRefresh
{
    self.tableView.mj_header = [LYRefreshHeader headerWithRefreshingTarget:self
                                                          refreshingAction:@selector(loadRequest)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [LYRefreshFooter footerWithRefreshingTarget:self
                                                          refreshingAction:@selector(loadMoreRequest)];
}

- (NSString *)aParam
{
    if (self.parentViewController.class == [LYNewController class]) {
        return @"newlist";
    }
    return @"list";
}

- (void)playVideoCellSetting:(NSNotification *)noti {
    self.playVideoCellSelected.stopPlay = YES;
    
    LYTopicCell *cell = (LYTopicCell *)noti.userInfo[@"PlayCell"];
    self.playVideoCellSelected = cell;
}

- (void)pausePlayVideo {
    self.playVideoCellSelected.pausePlay = YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Load Request
- (void)loadRequest
{
    //停止上拉加载操作
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    if (self.playVideoCellSelected) {
        self.playVideoCellSelected.stopPlay = YES;
        self.playVideoCellSelected = nil;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params
             progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         WriteFileToDeskWithName(responseObject, @"all");
         self.maxtime = responseObject[@"info"][@"maxtime"];
         self.topics = [LYTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
         [self.tableView reloadData];
         
         [self.tableView.mj_header endRefreshing];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"请求失败---%@", error.description);
         [self.tableView.mj_header endRefreshing];
     }];
}

- (void)loadMoreRequest
{
    //停止下拉刷新操作
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"maxtime"] = self.maxtime;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params
             progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         self.maxtime = responseObject[@"info"][@"maxtime"];
         [self.topics addObjectsFromArray:[LYTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]]];
         [self.tableView reloadData];
         
         [self.tableView.mj_footer endRefreshing];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"请求失败---%@", error.description);
         [self.tableView.mj_footer endRefreshing];
     }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicCell];
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.topics[indexPath.row].topicHeight + LYMargin;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.playVideoCellSelected.pausePlay = YES;
    
    LYCommentViewController *commentVC = [[LYCommentViewController alloc] init];
    commentVC.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVC animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray *visibleCells = self.tableView.visibleCells;
    
    if (!([visibleCells containsObject:self.playVideoCellSelected]) && self.playVideoCellSelected) {
        [[NSNotificationCenter defaultCenter] postNotificationName:UIVideoCellDidHideNotification object:self.tableView];
        self.playVideoCellSelected = nil;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidScroll:scrollView];
}

@end
