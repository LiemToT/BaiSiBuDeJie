//
//  LYMineController.m
//  百思不得姐OC
//
//  Created by linyi on 16/6/28.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYMineController.h"
#import "LYMeCell.h"
#import "LYFooterView.h"
#import "LYSettingController.h"

@interface LYMineController ()

@end

@implementation LYMineController
- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    [self initNavigation];
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
}

- (void)initTableView
{
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(LYMargin - 35, 0, 0, 0);
    
    self.tableView.tableFooterView = [[LYFooterView alloc] init];
    
    self.view.backgroundColor = LYNormalBgColor;
}

- (void)initNavigation
{
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *settingBarItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonBarItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingBarItem, moonBarItem];
}

- (void)settingClick {
    LYSettingController *settingController = [[LYSettingController alloc] init];
    [self.navigationController pushViewController:settingController animated:true];
}

- (void)moonClick {
    LYLogFunc;
}

#pragma mark - UITableView Delegate 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    LYMeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[LYMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
    } else {
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}
@end









