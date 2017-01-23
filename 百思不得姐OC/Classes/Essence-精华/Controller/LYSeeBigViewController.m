//
//  LYSeeBigViewController.m
//  百思不得姐OC
//
//  Created by linyi on 16/7/21.
//  Copyright © 2016年 linyi. All rights reserved.
//

#import "LYSeeBigViewController.h"
#import "LYTopic.h"
#import <UIImageView+WebCache.h>
#import <Photos/Photos.h>
#import <SVProgressHUD.h>

@interface LYSeeBigViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation LYSeeBigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.delegate = self;
    [self.view insertSubview:scrollView atIndex:0];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    WeakSelf
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error) return;
        weakSelf.saveButton.enabled = true;
    }];
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    imageView.ly_x = 0;
    imageView.ly_width = scrollView.ly_width;
    
    imageView.ly_height = imageView.ly_width * self.topic.height / self.topic.width;
    
    if (imageView.ly_height > scrollView.ly_height) {
        imageView.ly_y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.ly_height);
    } else {
        imageView.ly_centerY = scrollView.ly_height / 2;
    }
    
    CGFloat scale = self.topic.width / imageView.ly_width;
    
    if (scale > 1) {
        scrollView.maximumZoomScale = scale;
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:self completion:nil];
}

- (IBAction)save:(id)sender {
    //直接保存到相机胶卷中
    //UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    //保存图片到指定相簿,需要用到Photo框架
    //判断是否开启了相册权限
    /*
    PHAuthorizationStatusNotDetermined = 0, // User has not yet made a choice with regards to this application
    PHAuthorizationStatusRestricted,        // This application is not authorized to access photo data.
                                            // The user cannot change this application’s status, possibly due to active restrictions
                                            //   such as parental controls being in place.
    PHAuthorizationStatusDenied,            // User has explicitly denied this application access to photos data.
    PHAuthorizationStatusAuthorized         // User has authorized this application to access photos data.
     */
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusRestricted) {
        NSLog(@"系统受限,无法访问");
    } else if (status == PHAuthorizationStatusDenied) {
        NSLog(@"无照片访问权限,需重新设置");
    } else if (status == PHAuthorizationStatusAuthorized) {
        NSLog(@"有照片访问权限");
        [self saveImage];
    } else if (status == PHAuthorizationStatusNotDetermined) {
        NSLog(@"并未决定");
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                [self saveImage];
            }
        }];
    }
}

- (void)saveImage
{
    __block NSString *assetIdentifier = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        //1.保存照片到相机胶卷
        assetIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (!success) {
            [self showErrorWithText:@"保存图片到相机胶卷失败"];
            return;
        }

        //2.获取相簿
        PHAssetCollection *assetCollection = [self createdAssetCollection];
        
        if (assetCollection == nil) {
            [self showErrorWithText:@"创建相簿失败"];
            return;
        }
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            //3.把保存的照片添加到相簿中
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetIdentifier] options:nil].lastObject;
            
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
            [request addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                [self showSuccessWithText:@"保存成功"];
            } else {
                [self showErrorWithText:@"保存失败"];
            }
        }];
    }];
}

- (PHAssetCollection *)createdAssetCollection
{
    //判断是否已存在相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:@"百思"]) {
            return assetCollection;
        }
    }
    
    //没有对应相簿,需重新创建
    __block NSString *assetCollectionIdentifier = nil;
    NSError *error = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetCollectionIdentifier = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:@"百思"].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];

    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[assetCollectionIdentifier] options:nil].lastObject;
}

- (void)showSuccessWithText:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:text];
    });
}

- (void)showErrorWithText:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showErrorWithStatus:text];
    });
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"图片保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"图片保存成功!"];
    }
}
@end
