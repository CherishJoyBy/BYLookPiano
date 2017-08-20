//
//  BYMusicListViewController.h
//  LookPiano
//
//  Created by lby on 2017/8/14.
//  Copyright © 2017年 llk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BYMusicList.h"

@interface BYMusicListViewController : UIViewController

@property (nonatomic, assign) BYTwoLevelMusicType twoLevelMusicType;
@property (nonatomic, assign) BOOL connectSuccess;
/**
 传递二级类型创建三级音乐控制器
 
 @param twoLevelMusicType 音乐类型
 @return 返回BYMusicListViewController类型的控制器
 */
+ (instancetype)createViewControllerWithMusicType:(BYTwoLevelMusicType)twoLevelMusicType;
@end
