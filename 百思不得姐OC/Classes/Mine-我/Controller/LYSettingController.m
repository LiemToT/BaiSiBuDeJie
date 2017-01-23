//
//  LYSettingController.m
//  百思不得姐OC
//
//  Created by linyi on 16/7/8.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYSettingController.h"
#import "LYClearCacheCell.h"

@interface LYSettingController ()

@end

@implementation LYSettingController

static NSString * const ClearCacheCellID = @"ClearCell";
static NSString * const SettingCellID = @"SettingCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = LYNormalBgColor;
    
    [self.tableView registerClass:[LYClearCacheCell class] forCellReuseIdentifier:ClearCacheCellID];
}

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.row == 0) {
        return [tableView dequeueReusableCellWithIdentifier:ClearCacheCellID];
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingCellID];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SettingCellID];
        }
        
        if (indexPath.row == 1) {
            cell.textLabel.text = @"检查更新";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"给我们评分";
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"推送设置";
        } else {
            cell.textLabel.text = @"关于我们";
        }
        
        return cell;
    }
}

@end
