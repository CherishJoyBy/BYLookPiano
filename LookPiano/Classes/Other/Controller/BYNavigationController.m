//
//  BYNavigationController.m
//  LookPiano
//
//  Created by lby on 2017/8/14.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "BYNavigationController.h"
#import "BYConnectViewController.h"
#import "BYMusicListViewController.h"
#import "UIViewController+MMDrawerController.h"
#import <MMDrawerController.h>

@interface BYNavigationController ()

@end

@implementation BYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置隐藏,后续需要设置显示才能显示nav的其他内容
//    self.navigationBarHidden = YES;
    // 设置透明度,后续不需要设置
    [[[self.navigationBar subviews] objectAtIndex:0] setAlpha:0];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 1)
    {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];

        // 以下三行设置正常状态的箭头颜色
        UIImage *normalImg = [[UIImage imageNamed:@"navigationButtonReturn"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [backButton setImage: normalImg forState:UIControlStateNormal];
        // 设置箭头颜色为白(UI图原为白色)
        backButton.tintColor = [UIColor whiteColor];
        
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        // 这句代码放在sizeToFit后面
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, - 20, 0, 0);
        [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    // 隐藏底部的工具条
    viewController.hidesBottomBarWhenPushed = YES;
    
    [super pushViewController:viewController animated:animated];
}

- (void)backClick
{
    [self popViewControllerAnimated:YES];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];;
}

@end
