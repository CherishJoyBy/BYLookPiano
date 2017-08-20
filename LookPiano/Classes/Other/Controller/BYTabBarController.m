//
//  BYTabBarController.m
//  LookPiano
//
//  Created by lby on 2017/8/14.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "BYTabBarController.h"
#import "BYNavigationController.h"
#import "BYConnectViewController.h"

@interface BYTabBarController ()

@end

@implementation BYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"BYConnectViewController" bundle:nil];
    BYConnectViewController *connectVc = [sb instantiateInitialViewController];
    
    BYNavigationController *navVc = [[BYNavigationController alloc] initWithRootViewController:connectVc];
    [self addChildViewController:navVc];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
