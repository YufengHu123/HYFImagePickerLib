//
//  HYFBasePreViewCell.h
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/28.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYFAssetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HYFBasePreViewCell : UICollectionViewCell
@property (nonatomic,strong) NSIndexPath * indexPath;

-(void)initView;
-(instancetype)initWithFrame:(CGRect)frame;
@end


/**
 图片预览自定义视图、
 **/
@protocol HYFPhotoPreViewContentDelegate <NSObject>
@optional
-(void)sigleTapAction;  //sigle click
-(void)doubleTapAction; //double click
@end
@interface HYFPhotoPreViewContent:UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *imageContainerView;

@property (nonatomic, assign) BOOL allowCrop;
@property (nonatomic, assign) CGRect cropRect;
@property (nonatomic, assign) BOOL scaleAspectFillCrop;
@property (nonatomic, strong) HYFAssetModel *model;
@property (nonatomic,weak) id<HYFPhotoPreViewContentDelegate>delegate;
@property (nonatomic,strong) HYFAssetModel * assetModel;
@end
/**
 图片预览cell、
 **/
@protocol HYFPhotoPreViewDelegate <NSObject>
@end
@interface HYFPhotoPreViewCell :HYFBasePreViewCell
@property (nonatomic,weak) id<HYFPhotoPreViewDelegate> delegate;
@property (nonatomic,weak) HYFAssetModel * assetModel;
- (void)recoverSubviews;
@end
/**
 GIF预览cell、
 **/
@interface HYFGIFPreViewiewCell :HYFBasePreViewCell
@property (nonatomic,weak) HYFAssetModel * assetModel;

@end


/**
 Video预览cell、
 **/
@interface HYFVideoPreViewCell : HYFBasePreViewCell

@end

NS_ASSUME_NONNULL_END
