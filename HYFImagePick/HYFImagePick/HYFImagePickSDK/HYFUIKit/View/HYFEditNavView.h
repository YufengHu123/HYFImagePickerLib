//
//  HYFEditNavView.h
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/7/2.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HYFEditNavViewDelegate <NSObject>
@optional
-(void)leftNavBtnClick;
-(void)rightNavBtnClick;
@end
@interface HYFEditNavView : UIView
@property (nonatomic,weak) id<HYFEditNavViewDelegate>delegate;
@end


@protocol HYFEditBottomViewDelegate <NSObject>

@end
@interface HYFEditBottomView : UIView
@property (nonatomic,weak) id<HYFEditBottomViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
