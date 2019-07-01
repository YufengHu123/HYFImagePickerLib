//
//  UIViewController+Util.m
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/25.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import "UIViewController+Util.h"

@implementation UIViewController (Util)

-(UIViewController *)currentTopVC{
    NSAssert2([self isKindOfClass:[UIViewController class]], @"%s方法的调用对象不是控制器，其类型为%@", __func__ ,NSStringFromClass([self class]));
    if ([self isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController * tabBarController = (UITabBarController * ) self;
        return [tabBarController.selectedViewController currentTopVC];
        
    }else if ([self isKindOfClass:[UINavigationController class]]){
        UINavigationController * navigationController = (UINavigationController * ) self;
        return [navigationController.topViewController currentTopVC];
        
    }else{
        if (self.presentedViewController) {
            return [self.presentedViewController currentTopVC];
        }else{
            return self;
        }
    }
}
@end
