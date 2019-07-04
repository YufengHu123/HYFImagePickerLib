//
//  HYFEditVC.m
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/7/2.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import "HYFEditVC.h"
#import "HYFEditNavView.h"
#import "HYFMacroHeader.h"

@interface HYFEditVC ()<
HYFEditNavViewDelegate,
HYFEditBottomViewDelegate>

@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) HYFEditNavView * NavView;
@property (nonatomic,strong) HYFEditBottomView * bottomView;
@end

@implementation HYFEditVC

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}
-(HYFEditNavView *)NavView{
    if (!_NavView) {
        _NavView = [[HYFEditNavView alloc]initWithFrame:CGRectMake(0, kHYFStatusBarHeight, KHYFScreenWidth, 50)];
        _NavView.delegate = self;
    }
    return _NavView;
}
-(HYFEditBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[HYFEditBottomView alloc]initWithFrame:CGRectMake(0, KHYFScreenHeight - kHYFTabBarMoreHeight - 100, KHYFScreenWidth, 100)];
        _bottomView.delegate = self;
    }
    return _bottomView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.NavView];
    [self.view addSubview:self.bottomView];
    self.imageView.image = self.assetModel.thumbImage;
}

- (void)setAssetModel:(HYFAssetModel *)assetModel{
    _assetModel = assetModel;
    self.imageView.image = assetModel.thumbImage;
}

#pragma mark HYFEditNavViewDelegate
-(void)leftNavBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightNavBtnClick{
    //do something
}

@end
