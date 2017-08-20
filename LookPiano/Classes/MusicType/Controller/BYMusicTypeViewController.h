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

@property (nonatomic, assign) BYMusicKind musicKind;


/**
 类方法创建音乐详情控制器

 @param musicKind 音乐类型
 @return 返回BYMusicTypeViewController类型的控制器
 */
+ (instancetype)createViewControllerWithMusicKind:(BYMusicKind)musicKind;

@end
