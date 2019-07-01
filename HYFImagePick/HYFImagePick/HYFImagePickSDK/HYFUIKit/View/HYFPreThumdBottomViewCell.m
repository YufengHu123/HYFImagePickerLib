//
//  HYFPreThumdBottomViewCell.m
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/30.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import "HYFPreThumdBottomViewCell.h"
@interface HYFPreThumdBottomViewCell()

@end

@implementation HYFPreThumdBottomViewCell

-(UIImageView *)thumdIamgeView{
    if (!_thumdIamgeView) {
        _thumdIamgeView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
        _thumdIamgeView.userInteractionEnabled = YES;
    }
    return _thumdIamgeView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}
-(void)setAssetModel:(HYFAssetModel *)assetModel{
    _assetModel = assetModel;
    self.thumdIamgeView.image = assetModel.thumbImage;
}
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
    if (indexPath.row == 0) {
        self.thumdIamgeView.layer.borderWidth = 2;
        self.thumdIamgeView.layer.borderColor = [UIColor redColor].CGColor;
    }
}
-(void)initView{
    [self.contentView addSubview:self.thumdIamgeView];
}
@end
