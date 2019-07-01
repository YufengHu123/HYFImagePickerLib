//
//  HYFAlbumTool.m
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/25.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import "HYFAlbumTool.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>

@implementation HYFAlbumTool

+ (NSInteger)authorizationStatus
{
    return [PHPhotoLibrary authorizationStatus];
}

/**
 当某些情况下AuthorizationStatus==AuthorizationStatusNotDetermined时，
 无法弹出系统首次使用的授权alertView，系统应用设置里亦没有相册的设置，此时将无法使用，故作以下操作，弹出系统首次使用的授权alertView
 PHAuthorizationStatusNotDetermined = 0, // User has not yet made a choice with regards to this application
 PHAuthorizationStatusRestricted,        // This application is not authorized to access photo data.
 PHAuthorizationStatusDenied,            // User has explicitly denied this application access to photos data.
 PHAuthorizationStatusAuthorized         // User has authorized this application to access photos data.
 @return is author or not
 */
+ (BOOL)authorizationPhotoLibraryStatusAuthorized
{
    NSInteger status = [self.class authorizationStatus];
    if (status == 0)
    {
        [[self class] _requestAuthorizationWithCompletion:nil];
    }
    return status == 3;
}
//AuthorizationStatus == AuthorizationStatusNotDetermined 时询问授权弹出系统授权alertView

+ (void)_requestAuthorizationWithCompletion:(void (^)(void))completion
{
    void (^callCompletionBlock)(void) = ^() {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion){completion();}
        });
    };
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (callCompletionBlock)
            {
                callCompletionBlock();
            }
        }];
    });
}

//
///**
// AVAuthorizationStatusNotDetermined = 0,
// AVAuthorizationStatusRestricted    = 1,
// AVAuthorizationStatusDenied        = 2,
// AVAuthorizationStatusAuthorized    = 3,
// @return Whether to authorize YES or NO
// */
//+ (BOOL)authorizationVideoStateAuthorized{
//  AVAuthorizationStatus state =  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//    if (state == AVAuthorizationStatusAuthorized) {
//        return  YES;
//    }else{
//        return NO;
//    }
//}
@end
