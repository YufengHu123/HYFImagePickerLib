//
//  HYFAssetModel.h
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/27.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import "HYFBaseModel.h"
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface HYFAssetModel : HYFBaseModel
@property (nonatomic,strong) UIImage * thumbImage;
@property (nonatomic,strong) NSDictionary * info;
@property (nonatomic,assign) BOOL isSelect;
@end


NS_ASSUME_NONNULL_END
