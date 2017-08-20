//
//  BYMusicType.h
//  LookPiano
//
//  Created by lby on 2017/8/15.
//  Copyright © 2017年 llk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,BYOneLevelMusicType)
{
    // 热榜
    BYOneLevelMusicTypeHotList,
    // 主题
    BYOneLevelMusicTypeTheme,
    // 类型
    BYOneLevelMusicTypeClassification
};

@interface BYMusicType : NSObject

@end
