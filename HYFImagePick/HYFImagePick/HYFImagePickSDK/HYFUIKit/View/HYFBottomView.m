//
//  HYFBottomView.m
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/30.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import "HYFBottomView.h"
#import "HYFMacroHeader.h"
#import "HYFAlbumDataCenter.h"


@interface HYFBottomView()
@property (nonatomic,strong) UIButton * previewBtn;
@property (nonatomic,strong) UIButton * sendBtn;
@end
@implementation HYFBottomView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}
-(UIButton *)previewBtn{
    if(!_previewBtn){
        _previewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_previewBtn setFrame:CGRectMake(10, 10, 50, 20)];
        [_previewBtn setTitle:@"预览" forState:UIControlStateNormal];
        [_previewBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_previewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_previewBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        _previewBtn.enabled = NO;
    }
    return _previewBtn;
}
-(UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendBtn setFrame:CGRectMake(KHYFScreenWidth - 60, 10, 50, 20)];
        [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_sendBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        _sendBtn.enabled = NO;
    }
    return _sendBtn;
}
-(void)initView{}
@end
#pragma mark HYFPickerBottomView
@interface HYFPickerBottomView()
@end
@implementation HYFPickerBottomView
-(void)initView{
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:self.sendBtn];
    [self addSubview:self.previewBtn];
    [self.sendBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.previewBtn addTarget:self action:@selector(previewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark action
-(void)previewBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(previewBtnClickWithIndex)]) {
        [self.delegate previewBtnClickWithIndex];
    }
}
-(void)sendBtnClick:(UIButton *)btn{
    if (self.delegate &&[ self.delegate respondsToSelector:@selector(sendBtnClick)]) {
        [self.delegate sendBtnClick];
    }
}
-(void)refreshBtnState{
    if ( HYFDataCenter.selectArr.count > 0) {
        self.previewBtn.enabled = YES;
        self.sendBtn.enabled = YES;
    }else{
        self.previewBtn.enabled = NO;
        self.sendBtn.enabled = NO;
    }
}
@end


#pragma mark HYFPreViewBottomViewDelegate
@interface HYFPreViewBottomView()
@end

@implementation HYFPreViewBottomView
-(void)initView{
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:self.sendBtn];
    [self addSubview:self.previewBtn];
    [self.sendBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.previewBtn addTarget:self action:@selector(previewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)editBtnClick:(UIButton *)btn{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(previewBtnClickWithIndex)]) {
//        [self.delegate previewBtnClickWithIndex];
//    }
}
-(void)sendBtnClick:(UIButton *)btn{
//    if (self.delegate &&[ self.delegate respondsToSelector:@selector(sendBtnClick)]) {
//        [self.delegate sendBtnClick];
//    }
}

@end

#import "HYFPreThumdBottomViewCell.h"
#import "UIView+HYF.h"
@interface HYFPreThumbBottomView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView * thumdCollectionView;
@end
@implementation HYFPreThumbBottomView
-(UICollectionView *)thumdCollectionView{
    if (!_thumdCollectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(self.height, self.height);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 1;
        _thumdCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KHYFScreenWidth, 80) collectionViewLayout: layout];
        _thumdCollectionView.backgroundColor = [UIColor blackColor];
        _thumdCollectionView.contentInset = UIEdgeInsetsMake(0, 1, 0, 1);;
        [_thumdCollectionView registerClass:[HYFPreThumdBottomViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HYFPreThumdBottomViewCell class])];
        _thumdCollectionView.delegate = self;
        _thumdCollectionView.dataSource = self;
        _thumdCollectionView.pagingEnabled = YES;
        _thumdCollectionView.backgroundColor = [UIColor blackColor];
        _thumdCollectionView.showsVerticalScrollIndicator = NO;
        _thumdCollectionView.showsVerticalScrollIndicator = NO;
    }
    return _thumdCollectionView;
}
-(void)refreshViewWithModel:(HYFAssetModel *)model{
    
    
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.thumdCollectionView];
    if (HYFDataCenter.selectArr.count) {
        [self addSubview:self.thumdCollectionView];
        [self.thumdCollectionView reloadData];
    }else{
        self.hidden = YES;
    }
}
#pragma mark collection-delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HYFPreThumdBottomViewCell * cell = (HYFPreThumdBottomViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setIsCurrentPreCell:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(thumbCellClick:andModel:)]) {
        [self.delegate thumbCellClick:indexPath andModel:HYFDataCenter.albumRollArr[indexPath.row]];
    }
    
}
#pragma mark collection-dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return HYFDataCenter.albumRollArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HYFAssetModel *model = HYFDataCenter.albumRollArr[indexPath.row];
    HYFPreThumdBottomViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HYFPreThumdBottomViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[HYFPreThumdBottomViewCell alloc]init];
    }
    cell.indexPath = indexPath;
    cell.assetModel = model;
    return cell;
}
@end
