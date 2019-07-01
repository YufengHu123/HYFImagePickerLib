//
//  HYFPhotosPickerCell.h
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/27.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYFAssetModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HYFPhotoPickerCellDelegate <NSObject>
@optional
-(void)cellSelectBtnClick:(HYFAssetModel *)model andIndexPath:(NSIndexPath *)indexPath;
@end

@interface HYFPhotosPickerCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,weak) HYFAssetModel * model;
@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,weak) id <HYFPhotoPickerCellDelegate> delegate;

-(void)setModel:(HYFAssetModel * _Nullable)model;


@end

NS_ASSUME_NONNULL_END
