//
//  BYHome.m
//  LookPiano
//
//  Created by lby on 2017/8/18.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "BYHome.h"
#import "BYHTTPSessionManager.h"
#import "MJExtension.h"

@implementation BYHome

//+ (instancetype)homeWithDict:(NSDictionary *)dict
//{
//    BYHome *home = [[BYHome alloc] init];
//    
//    [home setValuesForKeysWithDictionary:dict];
//    
//    return home;
//}
//
//- (void)setValue:(id)value forUndefinedKey:(NSString *)key
//{
//    
//}

+ (void)loadCycleDataWithURLString:(NSString *)URLString successBlock:(void (^)(NSArray *))successBlock failedBlock:(void (^)(NSError *))failedBlock
{
    [BYHTTPSessionManager GET:URLString params:nil successBlock:^(id responseObject) {
        
//        // 通过key,取字典数组
//        NSArray *dictArr = responseObject[@"obj"];
//        
//        // 定义临时可变数组,保存模型对象
//        NSMutableArray *tmpM = [NSMutableArray arrayWithCapacity:dictArr.count];
//        // 遍历字典数组,取出字典,实现字典转模型
//        [dictArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            BYHome *model = [BYHome homeWithDict:obj];
//            [tmpM addObject:model];
//        }];
        
        // 字典数组(一个数组中有好几个字典)转模型数组
        NSArray *homeArr = [BYHome mj_objectArrayWithKeyValuesArray:responseObject[@"obj"]];
        
        // 当模型数组转好了之后,需要把模型数组回调到CycleVC
        if (successBlock)
        {
//            successBlock(tmpM.copy);
            successBlock(homeArr);
        }
    } failureBlock:^(NSError *error) {
        
        if (failedBlock)
        {
            failedBlock(error);
        }
    }];
}

+ (void)loadBtnDataWithURLString:(NSString *)URLString successBlock:(void (^)(NSArray *))successBlock failedBlock:(void (^)(NSError *))failedBlock
{
    [BYHTTPSessionManager GET:URLString params:nil successBlock:^(id responseObject) {
        
        NSArray *homeArr = [BYHome mj_objectArrayWithKeyValuesArray:responseObject[@"obj"]];
        if (successBlock)
        {
            successBlock(homeArr);
        }
    } failureBlock:^(NSError *error) {
        if (failedBlock)
        {
            failedBlock(error);
        }
    }];
}

- (NSString *)description
{
//    return [NSString stringWithFormat:@"%@--%@",self.imgUrl,self.imgId];
    return [NSString stringWithFormat:@"%@",self.imgUrl];
}

@end
