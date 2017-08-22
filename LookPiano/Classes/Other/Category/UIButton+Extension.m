//
//  UIButton+Extension.m
//  LookPiano
//
//  Created by lby on 2017/8/23.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (void)setNormalTitleColor:(UIColor *)normalTitleColor selectTitleColor:(UIColor *)selectTitleColor
{
    [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [self setTitleColor:selectTitleColor forState:UIControlStateSelected];
}

@end
