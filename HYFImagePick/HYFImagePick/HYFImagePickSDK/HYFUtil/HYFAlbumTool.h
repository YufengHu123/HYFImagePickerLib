//
//  HYFAlbumTool.h
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/25.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYFAlbumTool : NSObject


/**
Whether the album permission is enabled

 @return YES or NO
 */
+ (BOOL)authorizationPhotoLibraryStatusAuthorized;

//+ (BOOL)authorizationVideoStateAuthorized;

@end

NS_ASSUME_NONNULL_END
