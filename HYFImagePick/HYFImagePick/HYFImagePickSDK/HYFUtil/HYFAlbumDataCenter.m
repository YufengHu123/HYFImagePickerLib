//
//  HYFAlbumDataCenter.m
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/26.
//  Copyright © 2019 胡玉峰. All rights reserved.

#import "HYFAlbumDataCenter.h"
#import "HYFAlbumManager.h"
#import "HYFAssetModel.h"

@interface HYFAlbumDataCenter ()<NSCopying>


@end
@implementation HYFAlbumDataCenter
-(NSMutableArray *)albumRollArr{
    if (!_albumRollArr) {
        _albumRollArr = [NSMutableArray new];
    }
    return _albumRollArr;
}
-(NSMutableArray *)selectArr{
    if (!_selectArr) {
        _selectArr = [NSMutableArray new];
    }
    return _selectArr;
}
-(void)clearAllData{
    [self.albumRollArr removeAllObjects];
    [self.selectArr removeAllObjects];
}
+(instancetype)shareInstance{
    static HYFAlbumDataCenter * _shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[super allocWithZone:NULL]init];
    });
    return _shareInstance;
}
-(void)initDataWith:(void (^)(BOOL))finshInitData{
    [HYFAlbumManager getCameraRoll:^(PHAssetCollection * _Nonnull cameraRoll) {
        [HYFAlbumManager getAllPhotosWith:cameraRoll isOrignial:YES and:^(NSArray<UIImage *> * _Nonnull Photos, NSArray<NSDictionary *> * _Nonnull infos) {
            for (NSInteger index = 0; index < Photos.count; index ++) {
                HYFAssetModel * model = [[HYFAssetModel alloc]init];
                model.info = infos[index];
                model.thumbImage = Photos[index];
                [self.albumRollArr addObject:model];
            }
            if (finshInitData) {
                finshInitData(YES);
            }
        }];
    }];
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    return [HYFAlbumDataCenter shareInstance];
}
-(id)copyWithZone:(NSZone *)zone{
    return [HYFAlbumDataCenter shareInstance];
}

@end
