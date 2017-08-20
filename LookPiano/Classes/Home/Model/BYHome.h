//
//  BYHome.h
//  LookPiano
//
//  Created by lby on 2017/8/18.
//  Copyright © 2017年 llk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYHome : NSObject
// 轮播器的图片
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, assign) NSNumber *imgId;
@property (nonatomic, copy) NSString *imgName;

/**
 *  加载图片轮播器的主方法
 *
 *  @param URLString    图片轮播器的数据的地址
 *  @param successBlock 加载数据成功的回调,把模型数组回调CycleVC
 *  @param failedBlock  加载数据失败的回到,把错误信息回调CycleVC
 */
+ (void)loadCycleDataWithURLString:(NSString *)URLString successBlock:(void(^)(NSArray *cycleList))successBlock failedBlock:(void(^)(NSError *error))failedBlock;
+ (void)loadBtnDataWithURLString:(NSString *)URLString successBlock:(void(^)(NSArray *btnDataList))successBlock failedBlock:(void(^)(NSError *error))failedBlock;

@end
