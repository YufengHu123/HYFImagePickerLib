//
//  HYFMacroHeader.h
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/27.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#ifndef HYFMacroHeader_h
#define HYFMacroHeader_h

//获取屏幕宽高
#define KHYFScreenWidth         [[UIScreen mainScreen] bounds].size.width
#define KHYFScreenHeight        [[UIScreen mainScreen] bounds].size.height

#define  KHYFIPhoneX (KHYFScreenWidth == 375.f && KHYFScreenHeight == 812.f ? YES : NO)
#define  KHYFIPhoneMAX (KHYFScreenWidth == 414.f && KHYFScreenHeight == 896.f ? YES : NO)

#define  kHYFStatusBarHeight    CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)
#define  KHYFNavHeight          (44+kHYFStatusBarHeight)
#define  kHYFTabBarMoreHeight   ((KHYFIPhoneX ||KHYFIPhoneMAX ) ? 34.f : 0.f)
#define  KHYFTabbarHeight       (kHYFTabBarMoreHeight + 49.f)

//强弱引用
#define KHYFWeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define kHYFStrongSelf(type) __strong typeof(type) type = weak##type;

//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif
//拼接字符串
#define kHYFFormat(string, args...)            [NSString stringWithFormat:string, args]
//颜色
#define HYFRGB(r, g, b)                        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

//读取本地图片
#define kHYFIMAGE(_X_) [UIImage imageNamed:_X_]



#endif /* HYFMacroHeader_h */
