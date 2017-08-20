//
//  BYMusicType.h
//  LookPiano
//
//  Created by lby on 2017/8/15.
//  Copyright © 2017年 llk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,BYMusicKind)
{
    // 流行
    BYMusicKindPop,
    // 儿童
    BYMusicKindChildren,
    // 年代
    BYMusicKindAge,
    // 热榜
    BYMusicKindHotList,
    // 主题
    BYMusicKindTheme,
    // 类型
    BYMusicKindClassification
};

@interface BYMusicType : NSObject

@end
