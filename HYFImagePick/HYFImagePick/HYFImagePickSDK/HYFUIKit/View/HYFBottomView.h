//
//  HYFBottomView.h
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/30.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark HYFBottomView
@interface HYFBottomView : UIView
-(instancetype)initWithFrame:(CGRect)frame;
@end


#pragma mark HYFPickerBottomView
@protocol HYFPickerBottomViewDelegate <NSObject>
@optional
-(void)previewBtnClickWithIndex;
-(void)sendBtnClick;
@end
@interface HYFPickerBottomView : HYFBottomView
@property (nonatomic,weak) id<HYFPickerBottomViewDelegate> delegate;
-(void)refreshBtnState;
@end
#pragma mark HYFPickerBottomView
@protocol HYFPreViewBottomViewDelegate <NSObject>
@optional
@end
@interface HYFPreViewBottomView : HYFBottomView
@property (nonatomic,weak) id<HYFPreViewBottomViewDelegate> delegate;
-(void)refreshBtnState;
@end
#pragma mark
@protocol HYFPreThumbBottomView <NSObject>
@optional
@end
@interface HYFPreThumbBottomView : UIView
@property (nonatomic,weak) id<HYFPreViewBottomViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
