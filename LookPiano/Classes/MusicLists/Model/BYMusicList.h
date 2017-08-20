//
//  BYMusicList.h
//  LookPiano
//
//  Created by lby on 2017/8/18.
//  Copyright © 2017年 llk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,BYTwoLevelMusicType)
{
    // 流行
    BYTwoLevelMusicTypePop = 4,
    // 儿童
    BYTwoLevelMusicTypeChildren = 13,
    // 年代
    BYTwoLevelMusicTypeAge = 9
};
@interface BYMusicList : NSObject

@end
