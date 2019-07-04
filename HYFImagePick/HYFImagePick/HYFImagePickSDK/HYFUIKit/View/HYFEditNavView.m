//
//  HYFEditNavView.m
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/7/2.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import "HYFEditNavView.h"
#import "HYFMacroHeader.h"
#import "UIView+HYF.h"


@interface HYFEditNavView ()

@property (nonatomic,strong) UIButton * leftNavBtn;
@property (nonatomic,strong) UIButton * rightNavBtn;

@end

@implementation HYFEditNavView

-(UIButton *)leftNavBtn{
    if (!_leftNavBtn) {
        _leftNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
         [_leftNavBtn setFrame:CGRectMake(10, 10, 70, 25)];
        [_leftNavBtn setTitle:@"cancel" forState:UIControlStateNormal];
        [_leftNavBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftNavBtn;
}
-(UIButton *)rightNavBtn{
    if (!_rightNavBtn) {
        _rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightNavBtn setFrame:CGRectMake(KHYFScreenWidth - 60, 10, 70, 25)];
        [_rightNavBtn setTitle:@"done" forState:UIControlStateNormal];
        [_rightNavBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightNavBtn;
}
#pragma mark action
-(void)leftBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(leftNavBtnClick)]) {
        [self.delegate leftNavBtnClick];
    }
}
-(void)rightBtnClick:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rightNavBtnClick)]) {
        [self.delegate rightNavBtnClick];
    }
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}
-(void)initView{
    [self addSubview:self.leftNavBtn];
    [self addSubview:self.rightNavBtn];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

typedef NS_ENUM(NSInteger,FUNCTIONBTN_TYPE){
    EDIT_BOTTOM_PAINT_BTN = 0, //画笔
    EDIT_BOTTOM_EMM_BTN ,  // 表情
    EDIT_BOTTOM_MASS_BTN , // 马赛克
    EDIT_BOTTOM_CUT_BTN   //剪切
};
#pragma mark HYFEditBottomView
@interface HYFEditBottomView ()
@property (nonatomic,strong) NSMutableArray * functionBtnArr;
@property (nonatomic,strong) NSArray * functionNormalImageArr;
@property (nonatomic,strong) NSArray * colorsArr;

@end
@implementation HYFEditBottomView
-(NSArray *)colorsArr{
    if (!_colorsArr) {
        _colorsArr = @[
                       [UIColor whiteColor],
                       [UIColor redColor],
                       [UIColor greenColor],
                       [UIColor blueColor],
                       ];
    }
    return _colorsArr;
}
-(NSMutableArray *)functionBtnArr{
    if (!_functionBtnArr) {
        _functionBtnArr = [NSMutableArray new];
    }
    return _functionBtnArr;
}
-(NSArray *)functionNormalImageArr{
    if (!_functionNormalImageArr) {
        _functionNormalImageArr= @[
                                   @"line",
                                   @"emm",
                                   @"word",
                                   @"ma",
                                   @"cut"
                                   ];
    }
    return _functionNormalImageArr;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}
-(void)initView{
    [self createFunctionBtn];
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, KHYFScreenWidth, 1)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:lineView];
}
-(void)createFunctionBtn{
    CGFloat btn_width = KHYFScreenWidth/self.functionNormalImageArr.count;
    CGFloat btn_height = 50;
    for (NSInteger  index = 0;  index< self.functionNormalImageArr.count; index++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:self.functionNormalImageArr[index] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.functionBtnArr addObject:btn];
        btn.tag = 100+index;
        [btn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setFrame:CGRectMake(btn_width * index, self.height - 50, btn_width, btn_height)];
        [self addSubview:btn];
    }
}
-(void)functionBtnClick:(UIButton *)btn{
    NSInteger btnTag = btn.tag - 100;
    switch (btnTag) {
        case EDIT_BOTTOM_PAINT_BTN:
            
            break;
        case EDIT_BOTTOM_EMM_BTN:
            
            break;
        case EDIT_BOTTOM_MASS_BTN:
            
            break;
        case EDIT_BOTTOM_CUT_BTN:
            
            break;
        default:
            break;
    }
}
@end
