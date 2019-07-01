//
//  HYFAlbumDataCenter.h
//  HYFImagePick
//
//  Created by 胡玉峰 on 2019/6/26.
//  Copyright © 2019 胡玉峰. All rights reserved.
//

/**
 相册数据中心
 **/
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


#define HYFDataCenter [HYFAlbumDataCenter shareInstance]

@interface HYFAlbumDataCenter : NSObject

//相册胶卷数组，包括所有
@property (nonatomic,strong)  NSMutableArray* albumRollArr;

@property (nonatomic,strong)  NSMutableArray * selectArr;

@property (nonatomic,strong) NSMutableArray * albumSectionArr;

+(instancetype)shareInstance;
-(void)initDataWith:(void(^)(BOOL isFinshInitData))finshInitData;
@end



NS_ASSUME_NONNULL_END
