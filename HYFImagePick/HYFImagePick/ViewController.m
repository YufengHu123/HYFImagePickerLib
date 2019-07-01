//
//  ViewController.m
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/25.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import "ViewController.h"
#import "HYFImagePickSDK/HYFUIKit/Category/UIViewController+Util.h"
#import "HYFImagePickSDK/HYFUtil/HYFAlbumTool.h"
#import "HYFImagePickSDK/HYFUtil/HYFAlbumManager.h"
#import "HYFImagePickSDK/HYFUtil/HYFAlbumDataCenter.h"
#import "HYFImagePickSDK/HYFUIKit/VC/HYFPhotosPickerVC.h"
#import "HYFImagePickSDK/HYFUIKit/Base/VC/HYFBaseNavVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ( [HYFAlbumTool authorizationPhotoLibraryStatusAuthorized]) {
        NSLog(@"授权成功");
    }
    [HYFAlbumDataCenter shareInstance];
//    [HYFAlbumTool authorizationPhotoLibraryStatusAuthorized];
     [HYFAlbumManager getCameraRoll:^(PHAssetCollection * _Nonnull cameraRoll) {
        
    }];
    HYFBaseNavVC *nav = [[HYFBaseNavVC alloc]initWithRootViewController:[HYFPhotosPickerVC new]];
    
    [self presentViewController:nav animated:YES completion:nil];

}


@end
