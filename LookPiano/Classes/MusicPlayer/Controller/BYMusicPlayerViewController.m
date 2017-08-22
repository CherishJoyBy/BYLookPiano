//
//  BYMusicPlayerViewController.m
//  LookPiano
//
//  Created by lby on 2017/8/19.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "BYMusicPlayerViewController.h"

@interface BYMusicPlayerViewController ()

@end

@implementation BYMusicPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.alpha = 1.0;
    UIBarButtonItem *connectItem = [UIBarButtonItem itemWithImage:@"iconDisConnect" highImage:@"iconDisConnect" target:self action:@selector(connectFailureClick)];
    
    self.navigationItem.rightBarButtonItem = connectItem;
}

- (void)connectFailureClick
{
    BYLogFunc
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
