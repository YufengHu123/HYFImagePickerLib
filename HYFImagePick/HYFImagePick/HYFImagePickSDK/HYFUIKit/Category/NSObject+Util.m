//
//  NSObject+Util.m
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/25.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import "NSObject+Util.h"
#import "UIViewController+Util.h"
#import "AppDelegate.h"

@implementation NSObject (Util)

-(UIViewController *)currentTopVC{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *rootVC = delegate.window.rootViewController;
    return [rootVC currentTopVC];
}

@end
