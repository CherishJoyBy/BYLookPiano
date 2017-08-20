//
//  BYMusicTypeViewController.h
//  LookPiano
//
//  Created by lby on 2017/8/14.
//  Copyright © 2017年 llk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYMusicType.h"

@interface BYMusicTypeViewController : UIViewController

@property (nonatomic, assign) BYOneLevelMusicType oneLevelMusicType;
@property (nonatomic, assign) BOOL connectSuccess;

/**
 传递一级类型创建二级音乐控制器

 @param oneLevelMusicType 音乐类型
 @return 返回BYMusicTypeViewController类型的控制器
 */
+ (instancetype)createViewControllerWithMusicType:(BYOneLevelMusicType)oneLevelMusicType;

@end
