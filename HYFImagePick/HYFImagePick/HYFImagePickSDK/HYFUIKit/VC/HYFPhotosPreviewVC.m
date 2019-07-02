//
//  HYFPhotosPreviewVC.m
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/28.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import "HYFPhotosPreviewVC.h"
#import "HYFPhotosPreviewCell.h"
#import "HYFMacroHeader.h"
#import "HYFAlbumDataCenter.h"
#import "HYFAssetModel.h"
#import "HYFPhotosPreviewLayout.h"
#import "HYFBasePreViewCell.h"
#import "UIView+HYF.h"
#import "HYFBottomView.h"

@interface HYFPhotosPreviewVC ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
HYFPhotosPreviewCellDelegate,
HYFPreThumbBottomViewDelegate>
@property (nonatomic,strong) UICollectionView * previewCollectionView;
@property (nonatomic,strong) HYFPreViewBottomView * preViewBottomView;
@property (nonatomic,strong) HYFPreThumbBottomView * preThumdBottomView;

@end

@implementation HYFPhotosPreviewVC
-(HYFPreViewBottomView *)preViewBottomView{
  if (!_preViewBottomView) {
    _preViewBottomView = [[HYFPreViewBottomView alloc]initWithFrame:CGRectMake(0, self.view.height - KHYFTabbarHeight, KHYFScreenWidth, KHYFTabbarHeight)];
//    _PreViewBottomView.delegate = self;
     }
  return _preViewBottomView;
}
-(HYFPreThumbBottomView *)preThumdBottomView{
    if (!_preThumdBottomView) {
        _preThumdBottomView = [[HYFPreThumbBottomView alloc]initWithFrame:CGRectMake(0, self.preViewBottomView.top - 75, KHYFScreenWidth, 75)];
        _preThumdBottomView.delegate = self;
    }
    return _preThumdBottomView;
}
-(UICollectionView *)previewCollectionView{
    if (!_previewCollectionView) {
        HYFPhotosPreviewLayout * layout = [[HYFPhotosPreviewLayout alloc]init];
         layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize =self.view.bounds.size;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        _previewCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(self.view.left, self.view.top, self.view.width,self.preViewBottomView.top )collectionViewLayout: layout];
        _previewCollectionView.backgroundColor = [UIColor blackColor];
        _previewCollectionView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);;
        [_previewCollectionView registerClass:[HYFPhotoPreViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HYFPhotoPreViewCell class])];
        _previewCollectionView.delegate = self;
        _previewCollectionView.dataSource = self;
        _previewCollectionView.pagingEnabled = YES;
        _previewCollectionView.backgroundColor = [UIColor whiteColor];
    }
    return _previewCollectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.previewCollectionView];
    [self.view addSubview:self.preViewBottomView];
    [self.view addSubview:self.preThumdBottomView];
    [self.previewCollectionView reloadData];
}

#pragma mark collection-delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark collection-dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return HYFDataCenter.albumRollArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HYFAssetModel *model = HYFDataCenter.albumRollArr[indexPath.row];
    HYFPhotoPreViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HYFPhotoPreViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[HYFPhotoPreViewCell alloc]init];
    }
    cell.indexPath = indexPath;
    cell.assetModel = model;
//    [cell recoverSubviews];
    return cell;
}
#pragma mark HYFPreThumbBottomView
-(void)thumbCellClick:(NSIndexPath *)indexPath andModel:(HYFAssetModel *)assetModel{
    if (assetModel) {
     NSInteger index = [HYFDataCenter.albumRollArr indexOfObject:assetModel];
     [self.previewCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}




@end
