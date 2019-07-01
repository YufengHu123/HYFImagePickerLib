//
//  HYFPhotosPreviewCell.m
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/28.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import "HYFPhotosPreviewCell.h"
#import "UIView+HYF.h"
#import "HYFMacroHeader.h"
@interface HYFPhotosPreviewCell();
@property (nonatomic,strong) UIScrollView * mainScrollView;
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,assign) BOOL  isDoubleTap;
@end

@implementation HYFPhotosPreviewCell

-(UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:self.contentView.bounds];
        _mainScrollView.backgroundColor = [UIColor blackColor];
    }
    return _mainScrollView;
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, self.contentView.width - 20, self.contentView.height - kHYFTabBarMoreHeight)];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor blackColor];
        [self initView];
        
    }
    return self;
}
-(void)initView{
    [self.contentView addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.imageView];
    
    UITapGestureRecognizer *touchTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchTapClick:)];
    touchTap.numberOfTapsRequired = 2;
    [self.imageView addGestureRecognizer:touchTap];
}
#pragma mark action
-(void)touchTapClick:(UITapGestureRecognizer *)tap{
    CGPoint doubleTapPoint = [tap locationInView:self.imageView];
    
    
    self.imageView.layer.anchorPoint =doubleTapPoint;
    NSLog(@"执行了");
    if (!self.isDoubleTap) {
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.transform  = CGAffineTransformMakeScale(3, 3);
           
//            self.imageView.width = self.imageView.width * 3;
//            self.imageView.height = self.imageView.height * 3;
        }];
        self.isDoubleTap = YES;
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.transform  = CGAffineTransformIdentity;
        }];
        self.isDoubleTap = NO;
    }
    
}

-(void)setModel:(HYFAssetModel *)model{
    _model = model;
    [self.imageView setImage:model.thumbImage];
}
@end
