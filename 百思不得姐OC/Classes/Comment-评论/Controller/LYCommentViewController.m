//
//  LYCommentViewController.m
//  百思不得姐OC
//
//  Created by linyi on 16/7/25.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYCommentViewController.h"
#import "LYComment.h"
#import "XMGCommentCell.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "LYTopic.h"
#import <MJExtension.h>
#import "LYSectionHeaderView.h"
#import "LYTopicCell.h"

@interface LYCommentViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 网络任务管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

/** 最热评论数组 */
@property (nonatomic, strong) NSArray<LYComment *> *hotestComments;
/** 最新评论数组 */
@property (nonatomic, strong) NSMutableArray<LYComment *> *latestComments;

//暂存最热评论
@property (nonatomic, strong) LYComment *hotestComent;

@property (nonatomic, weak) LYTopicCell *currentCell;

@end

@implementation LYCommentViewController

static NSString *const CommentCellID = @"comment";
static NSString *const SectionHeaderCellID = @"header";

#pragma mark - Lazy loading
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - Init Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"评论";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self setUpTableView];
    [self setUpRefresh];
    [self setUpHeader];
}

- (void)setUpTableView
{
    self.tableView.backgroundColor = LYNormalBgColor;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGCommentCell class]) bundle:nil] forCellReuseIdentifier:CommentCellID];
    [self.tableView registerClass:[LYSectionHeaderView class] forHeaderFooterViewReuseIdentifier:SectionHeaderCellID];
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)setUpRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
}

- (void)setUpHeader
{
    self.topic.topicHeight = 0;
    self.hotestComent = self.topic.topCmt;
    self.topic.topCmt = nil;
    
    UIView *header = [[UIView alloc] init];
    
    LYTopicCell *cell = [LYTopicCell ly_viewFromXib];
    cell.topic = self.topic;
    cell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.topic.topicHeight);
    self.currentCell = cell;
    
    header.ly_height = cell.frame.size.height + LYMargin * 2;
    [header addSubview:cell];
    self.tableView.tableHeaderView = header;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.currentCell.stopPlay = YES;
    
}

#pragma mark - HeaderRefresh Method
- (void)loadNewComments {
    /** 取消之前的所有请求 */
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1;
    
    // 发送请求
    WeakSelf
    [self.manager GET:LYRequestURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        WriteFileToDeskWithName(responseObject, @"newComments")
        
        /** 判断有无数据,当无数据时传的是非字典类型 */
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_header endRefreshing];
            return;
        }
        
        //最热评论模型数组
        self.hotestComments = [LYComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        //最新评论模型数组
        self.latestComments = [LYComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        /** 刷新TableView */
        [weakSelf.tableView reloadData];
        
        /** 停止上拉刷新控件 */
        [weakSelf.tableView.mj_header endRefreshing];
        
        if (self.latestComments.count == [responseObject[@"total"] integerValue]) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - FooterRefresh Method
- (void)loadMoreComments {
    /** 取消之前的所有请求 */
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"lastcid"] = [self.latestComments.lastObject ID];
    
    // 发送请求
    WeakSelf
    [self.manager GET:LYRequestURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        WriteFileToDeskWithName(responseObject, @"newComments")
        
        /** 判断有无数据,当无数据时传的是非字典类型 */
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_header endRefreshing];
            return;
        }
        
        //最新评论模型数组
        [self.latestComments addObjectsFromArray:[LYComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]]];
        
        /** 刷新TableView */
        [weakSelf.tableView reloadData];
        
        /** 停止上拉刷新控件 */
        [weakSelf.tableView.mj_footer endRefreshing];
        
        if (self.latestComments.count == [responseObject[@"total"] integerValue]) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Dealloc Method
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    self.topic.topicHeight = 0;
    self.topic.topCmt = self.hotestComent;
}

#pragma mark - KeyboardFrameChange Method
- (void)keyboardFrameChange:(NSNotification *)noti
{
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat keyboardY = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    self.bottomConstraint.constant = screenH - keyboardY;
    
    [UIView animateWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]  animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotestComments.count) return 2;
    if (self.latestComments.count) return 1;
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 && self.hotestComments.count)
        return self.hotestComments.count;

    return self.latestComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMGCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentCellID];
    
    if (indexPath.section == 0 && self.hotestComments.count)
    {
        cell.comment = self.hotestComments[indexPath.row];
    } else {
        cell.comment = self.latestComments[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableView Delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LYSectionHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SectionHeaderCellID];
    
    if (section == 0 && self.hotestComments.count)
    {
        header.textLabel.text = @"最热评论";
    } else {
        header.textLabel.text = @"最新评论";
    }
    return header;
}

@end













