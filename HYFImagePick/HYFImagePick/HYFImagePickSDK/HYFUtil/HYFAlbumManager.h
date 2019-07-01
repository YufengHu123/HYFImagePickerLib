//
//  HYFAlbumManager.h
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/25.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface HYFAlbumManager : NSObject

/**
 Get all albums

 @param finshBlock this block will return all albums
 */
+(void)getAllAlbums:(void(^)(PHFetchResult<PHAssetCollection *> * assetCollections))finshBlock;


/**
 get cameraRoll

 @param finshBlock this block will return cameraRoll type PHAssetCollection
 */
+(void)getCameraRoll:(void(^)(PHAssetCollection * cameraRoll ))finshBlock;

/**
 get all original photos from a PHAssetCollection

 @param assetCollection a params type PHAssetCollection
 @param isOriginal is original photos
 @param finshBlock this block will return all original photos and infos
 */
+(void)getAllPhotosWith:(PHAssetCollection *)assetCollection isOrignial:(BOOL)isOriginal and:(void(^)(NSArray<UIImage *> * Photos,NSArray<NSDictionary *> *infos))finshBlock;







@end

NS_ASSUME_NONNULL_END
