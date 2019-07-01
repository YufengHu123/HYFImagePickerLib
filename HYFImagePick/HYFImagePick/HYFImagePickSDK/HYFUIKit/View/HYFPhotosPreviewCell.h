//
//  HYFPhotosPreviewCell.h
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/28.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYFAssetModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HYFPhotosPreviewCellDelegate <NSObject>
@optional
@end
@interface HYFPhotosPreviewCell : UICollectionViewCell
@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,weak) HYFAssetModel * model;
@property (nonatomic,weak) id<HYFPhotosPreviewCellDelegate> delegate;


-(instancetype)initWithFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
