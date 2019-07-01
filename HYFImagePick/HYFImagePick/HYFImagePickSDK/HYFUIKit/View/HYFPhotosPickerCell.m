//
//  HYFPhotosPickerCell.m
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/27.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import "HYFPhotosPickerCell.h"
#import "HYFAlbumDataCenter.h"



@interface HYFPhotosPickerCell()
@property (nonatomic,strong) UIButton  * selectBtn;
@end

@implementation HYFPhotosPickerCell

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 5;
    }
    return _imageView;
}
-(UIButton *)selectBtn{
    if(!_selectBtn){
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"image_picker_unselect"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"image_picker_select"] forState:UIControlStateSelected];
        [_selectBtn setFrame:CGRectMake(self.contentView.frame.size.width - 25, 0, 25, 25)];
        [_selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}
-(void)selectBtnClick:(UIButton *)btn{
    self.model.isSelect = !self.model.isSelect;
    [self startSelectBtnAnmation:self.model.isSelect];
}
-(void)startSelectBtnAnmation:(BOOL)select{
    [UIView animateWithDuration:0.3 animations:^{
        self.selectBtn.transform = CGAffineTransformMakeScale(3, 3);
        self.selectBtn.transform = CGAffineTransformIdentity;
    }];
     self.selectBtn.selected = self.model.isSelect;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellSelectBtnClick:andIndexPath:)]) {
        [self.delegate cellSelectBtnClick:self.model andIndexPath:self.indexPath];
    }
}
-(void)setModel:(HYFAssetModel * _Nullable)model{
    if (_model != model) {
        _model = model;
        self.imageView.image = model.thumbImage;
    }
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}
-(void)initView{
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.selectBtn];
}
@end
