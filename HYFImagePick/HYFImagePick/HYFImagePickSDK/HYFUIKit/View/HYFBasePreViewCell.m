//
//  HYFBasePreViewCell.m
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/28.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import "HYFBasePreViewCell.h"
#import "UIView+HYF.h"
@interface HYFBasePreViewCell()
@end
@implementation HYFBasePreViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self initView];
    }
    return self;
}
-(void)initView{}
@end

#pragma mark HYFPhotoPreViewContent
@interface HYFPhotoPreViewContent ()
<UIScrollViewDelegate>

@end
@implementation HYFPhotoPreViewContent
#pragma mark--lazy load
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.bouncesZoom = YES;
        _scrollView.maximumZoomScale = 2.5;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.multipleTouchEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.scrollsToTop = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.delaysContentTouches = NO;
        _scrollView.canCancelContentTouches = YES;
        _scrollView.alwaysBounceVertical = NO;
        if (@available(iOS 11,*)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _scrollView;
}
-(UIView *)imageContainerView{
    if (!_imageContainerView) {
        _imageContainerView = [[UIView alloc] init];
        _imageContainerView.clipsToBounds = YES;
        _imageContainerView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return  _imageContainerView;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapClick:)];
        [self addGestureRecognizer:singleTap];
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapClick:)];
        doubleTap.numberOfTapsRequired = 2;
        [singleTap requireGestureRecognizerToFail:doubleTap];
        [self addGestureRecognizer:doubleTap];
        [self initView];
    }
    return self;
}
-(void)initView{
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageContainerView];
    [self.imageContainerView addSubview:self.imageView];
}
-(void)setAssetModel:(HYFAssetModel *)assetModel{
    _assetModel = assetModel;
    self.imageView.image = assetModel.thumbImage;
    [self.scrollView setZoomScale:1.0f animated:NO];
    [self recoverSubviews];
}
- (void)recoverSubviews {
    [_scrollView setZoomScale:_scrollView.minimumZoomScale animated:NO];
    [self resizeSubviews];
}
- (void)resizeSubviews {
    _imageContainerView.origin = CGPointZero;
    _imageContainerView.width = self.scrollView.width;
    UIImage *image = _imageView.image;
    if (image.size.height / image.size.width > self.height / self.scrollView.width) {
        _imageContainerView.height = floor(image.size.height / (image.size.width / self.scrollView.width));
    } else {
        CGFloat height = image.size.height / image.size.width * self.scrollView.width;
        if (height < 1 || isnan(height)) height = self.height;
        height = floor(height);
        _imageContainerView.height = height;
        _imageContainerView.centerY = self.height / 2;
    }
    if (_imageContainerView.height > self.height && _imageContainerView.height - self.height <= 1) {
        _imageContainerView.height = self.height;
    }
    CGFloat contentSizeH = MAX(_imageContainerView.height, self.height);
    _scrollView.contentSize = CGSizeMake(self.scrollView.width, contentSizeH);
    [_scrollView scrollRectToVisible:self.bounds animated:NO];
    _scrollView.alwaysBounceVertical = _imageContainerView.height <= self.height ? NO : YES;
    _imageView.frame = _imageContainerView.bounds;
}
#pragma mark Action
-(void)doubleTapClick:(UITapGestureRecognizer *)doubleTap{
    if (_scrollView.zoomScale > _scrollView.minimumZoomScale) {
        _scrollView.contentInset = UIEdgeInsetsZero;
        [_scrollView setZoomScale:_scrollView.minimumZoomScale animated:YES];
    } else {
        CGPoint touchPoint = [doubleTap locationInView:self.imageView];
        CGFloat newZoomScale = _scrollView.maximumZoomScale;
        CGFloat xsize = self.frame.size.width / newZoomScale;
        CGFloat ysize = self.frame.size.height / newZoomScale;
        [_scrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(doubleTapAction)]) {
        [self.delegate doubleTapAction];
    }
}
-(void)singleTapClick:(UITapGestureRecognizer *)sigleTap{
    if (self.delegate && [self.delegate respondsToSelector:@selector(sigleTapAction)]) {
        [self.delegate sigleTapAction];
    }
}
#pragma mark scrollerView--delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageContainerView;
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    scrollView.contentInset = UIEdgeInsetsZero;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self refreshImageContainerViewCenter];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
//    [self refreshScrollViewContentSize];
}
- (void)refreshImageContainerViewCenter {
    CGFloat offsetX = (_scrollView.width > _scrollView.contentSize.width) ? ((_scrollView.width - _scrollView.contentSize.width) * 0.5) : 0.0;
    CGFloat offsetY = (_scrollView.height > _scrollView.contentSize.height) ? ((_scrollView.height - _scrollView.contentSize.height) * 0.5) : 0.0;
    self.imageContainerView.center = CGPointMake(_scrollView.contentSize.width * 0.5 + offsetX, _scrollView.contentSize.height * 0.5 + offsetY);
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _scrollView.frame = CGRectMake(0, 0, self.width, self.height);
    [self recoverSubviews];
}
@end

#pragma mark HYFPhotoPreViewCell
@interface HYFPhotoPreViewCell()
@property (nonatomic,strong) HYFPhotoPreViewContent * previewView;

@end
@implementation HYFPhotoPreViewCell
-(void)initView{
    self.previewView = [[HYFPhotoPreViewContent alloc] initWithFrame:CGRectZero];
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:self.previewView];
}
-(HYFPhotoPreViewContent *)previewView{
    if (!_previewView) {
        _previewView = [[HYFPhotoPreViewContent alloc]initWithFrame:CGRectZero];
    }
    return _previewView;
}
-(void)setAssetModel:(HYFAssetModel *)assetModel{
    _assetModel = assetModel;
    _previewView.assetModel = assetModel;
}
- (void)recoverSubviews {
    [_previewView recoverSubviews];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.previewView.frame = self.bounds;
}
@end


#pragma mark GIFPreView
@interface HYFGIFPreViewiewCell()


@end

@implementation HYFGIFPreViewiewCell
-(void)setAssetModel:(HYFAssetModel *)assetModel{
//    assetModel = assetModel;
}

@end


#pragma mark VideoPreViewCell
@interface HYFVideoPreViewCell()

@end

@implementation HYFVideoPreViewCell

@end



