//
//  BYMusicTypeViewController.m
//  LookPiano
//
//  Created by lby on 2017/8/14.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "BYMusicTypeViewController.h"
#import "UIBarButtonItem+BYExtension.h"

@interface BYMusicTypeViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *musicTypeCollectionView;

@end

@implementation BYMusicTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    switch (self.musicKind) {
        
        case BYMusicKindPop:
            
            break;
        case BYMusicKindChildren:
            
            break;
        case BYMusicKindAge:
            
            break;
        case BYMusicKindHotList:
            
            break;
        case BYMusicKindTheme:
            
            break;
        case BYMusicKindClassification:
            
            break;
    }
}

- (void)setUpNav
{
//    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"iconDisConect" highImage:@"iconDisConect" target:self action:@selector(connectClick)];
    
    // 隐藏navigation背景
//    UIImage *tempImage = [[UIImage alloc] init];
//    [self.navigationController.navigationBar setBackgroundImage:tempImage forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:tempImage];
    
    self.navigationItem.title = @"MUSIC";
    
    NSMutableDictionary *titleAttributesDict = [NSMutableDictionary dictionary];
    titleAttributesDict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    titleAttributesDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:titleAttributesDict];
}

- (void)connectClick
{
    BYLogFunc
}

+ (instancetype)createViewControllerWithMusicKind:(BYMusicKind)musicKind
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass(self) bundle:nil];
    
    BYMusicTypeViewController *musicTypeVc = [sb instantiateInitialViewController];
    musicTypeVc.musicKind = musicKind;
    
    return musicTypeVc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
