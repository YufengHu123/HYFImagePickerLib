//
//  HYFPreThumdBottomViewCell.h
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/30.
//  Copyright © 2019 胡玉峰. All rights reserved.
//




#import "HYFPreThumdBottomViewCell.h"
#import <UIKit/UIKit.h>
#import "HYFAssetModel.h"
//#import "HYFAssetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYFPreThumdBottomViewCell : UICollectionViewCell
@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,weak) HYFAssetModel * assetModel;
@property (nonatomic,strong) UIImageView * thumdIamgeView;

-(instancetype)initWithFrame:(CGRect)frame;
-(void)changeSelecctStateWith:(NSIndexPath *)indexPath andModel:(HYFAssetModel *)assetModel;

@end

NS_ASSUME_NONNULL_END
