//
//  LYClearCacheCell.m
//  百思不得姐OC
//
//  Created by linyi on 16/7/8.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYClearCacheCell.h"
#import "SDImageCache.h"

@implementation LYClearCacheCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.accessoryView = loadingView;
        
        self.textLabel.text = @"清除缓存(计算缓存中...)";
        
        [self sizeReset];
    }
    
    return self;
}

- (void)sizeReset
{
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:1.5];
        
        CGFloat size = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:LYCachePath].ly_fileSize;
        
        NSLog(@"%@", [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]);
        size += [SDImageCache sharedImageCache].getSize;
        
        NSString *sizeText = nil;
        if (size >= pow(10, 9)) {  //单位GB
            sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
        } else if (size >= pow(10, 6)) {  //单位MB
            sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
        } else if (size >= pow(10, 3)) {  //单位KB
            sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
        } else {  //单位B
            sizeText = [NSString stringWithFormat:@"%.1fB", size];
        }
        
        weakSelf.textLabel.text = [NSString stringWithFormat:@"清除缓存(%@)", sizeText];
        weakSelf.userInteractionEnabled = false;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf.accessoryView != nil) {
                weakSelf.accessoryView = nil;
                weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            
            [weakSelf addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cleanCache)]];
            weakSelf.userInteractionEnabled = true;
        });
    });

}

- (void)cleanCache
{
    [SVProgressHUD showWithStatus:@"正在清除缓存"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMinimumDismissTimeInterval:0.5];
    
    __weak typeof(self) weakSelf = self;
    
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            [[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:LYCachePath] ly_cleanFileCache];
            [NSThread sleepForTimeInterval:2];
        });
        [SVProgressHUD showSuccessWithStatus:@"清除完毕"];
        weakSelf.textLabel.text = @"清除缓存(0.0B)";
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)self.accessoryView;
    [loadingView startAnimating];
}

@end
