//
//  UIButton+Extension.h
//  LookPiano
//
//  Created by lby on 2017/8/23.
//  Copyright © 2017年 llk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

/**
 设置按钮的背景色和图片

 @param normalTitleColor 正常文字颜色
 @param selectTitleColor 选中文字颜色
 @param normalBgColor 正常背景颜色
 @param selectBgColor 选中背景颜色
 */
- (void)setNormalTitleColor:(UIColor *)normalTitleColor selectTitleColor:(UIColor *)selectTitleColor;

@end
