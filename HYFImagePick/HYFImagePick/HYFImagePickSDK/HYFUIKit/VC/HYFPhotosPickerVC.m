//
//  HYFPhotosPickerVC.m
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/27.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import "HYFPhotosPickerVC.h"
#import "HYFMacroHeader.h"
#import "HYFPhotosPickerCell.h"
#import "HYFAlbumDataCenter.h"
#import "HYFAssetModel.h"
#import "HYFBottomView.h"
#import "UIView+HYF.h"
#import "HYFPhotosPreviewVC.h"

#define ItemView_Space   10
#define ItemView_Width  ( KHYFScreenWidth - 5*ItemView_Space) / 4


@interface HYFPhotosPickerVC ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
HYFPhotoPickerCellDelegate,
HYFPickerBottomViewDelegate>

@property (nonatomic,strong) UICollectionView * photoCollectionView;
@property (nonatomic,weak) NSMutableArray * photosDataSource;
@property (nonatomic,strong) HYFPickerBottomView * bottomView;
@end

@implementation HYFPhotosPickerVC
-(HYFPickerBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[HYFPickerBottomView alloc]initWithFrame:CGRectMake(0, self.view.height - KHYFTabbarHeight, KHYFScreenWidth, KHYFTabbarHeight)];
        _bottomView.delegate = self;
    }
    return _bottomView;
}
-(UICollectionView *)photoCollectionView{
    if (!_photoCollectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(ItemView_Width, ItemView_Width);
        layout.minimumLineSpacing = ItemView_Space;
        layout.minimumLineSpacing = ItemView_Space;
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        _photoCollectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout: layout];
        [_photoCollectionView registerClass:[HYFPhotosPickerCell class] forCellWithReuseIdentifier:NSStringFromClass([HYFPhotosPickerCell class])];
        _photoCollectionView.delegate = self;
        _photoCollectionView.dataSource = self;
        _photoCollectionView.backgroundColor = [UIColor whiteColor];
    }
    return _photoCollectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"所有图片";
    [self.navigationController.navigationBar setBarTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.view addSubview:self.photoCollectionView];
    [self.view addSubview:self.bottomView];
    
    __weak typeof(self) weakSelf = self;
    [[HYFAlbumDataCenter shareInstance]initDataWith:^(BOOL isFinshInitData) {
        if (isFinshInitData) {
            weakSelf.photosDataSource = [HYFAlbumDataCenter shareInstance].albumRollArr;
            [weakSelf.photoCollectionView reloadData];
        }
    }];
}

#pragma mark collection-delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[HYFPhotosPreviewVC new] animated:YES];
}

#pragma mark collection-dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photosDataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HYFAssetModel *model = self.photosDataSource[indexPath.row];
    HYFPhotosPickerCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HYFPhotosPickerCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[HYFPhotosPickerCell alloc]init];
    }
    cell.indexPath = indexPath;
    cell.model = model;
    cell.delegate = self;
    return cell;
}

#pragma mark cell-delegate
- (void)cellSelectBtnClick:(HYFAssetModel *)model andIndexPath:(NSIndexPath *)indexPath{
    if (model) {
        if (model.isSelect) {
            [HYFDataCenter.selectArr addObject:model];
        }else{
            [HYFDataCenter.selectArr removeObject:model];
        }
    }
    [self.bottomView refreshBtnState];
}

#pragma mark preview-deletate
-(void)previewBtnClickWithIndex{
    
}
-(void)sendBtnClick{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


@end
