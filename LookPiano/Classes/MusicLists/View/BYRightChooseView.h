//
//  BYRightChooseView.h
//  LookPiano
//
//  Created by lby on 2017/8/22.
//  Copyright © 2017年 llk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYRightChooseView : UIView

@property (nonatomic, assign) int musicListCount;


/**
 需要BYMusicListViewController赋值的block
 */
@property (nonatomic, copy) void(^chooseFinishBlcok)(int musicListCount, BOOL isCloseRightView);

@end
