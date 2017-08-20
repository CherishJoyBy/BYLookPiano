//
//  BYMusicTypeViewController.m
//  LookPiano
//
//  Created by lby on 2017/8/14.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "BYMusicTypeViewController.h"
#import "BYMusicTypeCell.h"
#import "BYMusicListViewController.h"
#import <MMDrawerController.h>

@interface BYMusicTypeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *musicTypeCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *musicTypeFlowLayout;

@end

static NSString *BYMusicTypeCellId = @"BYMusicTypeCellId";
@implementation BYMusicTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self setUpOneLevelMusicType];
    
    [self setupCollectionView];
}

#pragma mark - PrivateMethod
- (void)setupCollectionView
{
    self.musicTypeCollectionView.dataSource = self;
    self.musicTypeCollectionView.delegate = self;
    
    self.musicTypeCollectionView.showsHorizontalScrollIndicator = NO;
    self.musicTypeCollectionView.showsVerticalScrollIndicator = NO;
    self.musicTypeCollectionView.bounces = NO;
    
    self.musicTypeFlowLayout.minimumLineSpacing = 10;
    self.musicTypeFlowLayout.minimumInteritemSpacing = 0;
    
    CGSize collectionViewSize = self.musicTypeCollectionView.bounds.size;
    self.musicTypeFlowLayout.itemSize = CGSizeMake((collectionViewSize.width - 40) / 5, collectionViewSize.height);
    
    self.musicTypeCollectionView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
}

- (void)setUpOneLevelMusicType
{
    switch (self.oneLevelMusicType) {
            
        case BYOneLevelMusicTypeHotList:
            
            break;
        case BYOneLevelMusicTypeTheme:
            
            break;
        case BYOneLevelMusicTypeClassification:
            
            break;
    }
}

- (void)setUpNav
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"iconDisConnect" highImage:@"iconDisConnect" target:self action:@selector(connectFailureClick)];
    
    self.navigationItem.title = @"MUSIC";
    
    NSMutableDictionary *titleAttributesDict = [NSMutableDictionary dictionary];
    titleAttributesDict[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    titleAttributesDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:titleAttributesDict];
}

- (void)connectFailureClick
{
    BYLogFunc
}

- (void)connectSuccessClick
{
    BYLogFunc
}

+ (instancetype)createViewControllerWithMusicType:(BYOneLevelMusicType)oneLevelMusicType
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass(self) bundle:nil];
    
    BYMusicTypeViewController *musicTypeVc = [sb instantiateInitialViewController];
    musicTypeVc.oneLevelMusicType = oneLevelMusicType;
    
    return musicTypeVc;
}

#pragma mark - CollecitonView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BYMusicTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BYMusicTypeCellId forIndexPath:indexPath];
    
    cell.indexPath = indexPath;
    
    return cell;
}

#pragma mark - CollecitonView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"BYMusicListViewController" bundle:nil];
    BYMusicListViewController *musicListVc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:musicListVc animated:YES];
    
//    [self setUpDrawer];
}

- (void)setUpDrawer
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"BYMusicListViewController" bundle:nil];
    BYMusicListViewController *centerDrawer = [sb instantiateInitialViewController];
    
    UIViewController *rightDrawer = [[UIViewController alloc] init];
    rightDrawer.view.backgroundColor = BYRandomColor;
    
    MMDrawerController *drawerController = [[MMDrawerController alloc] initWithCenterViewController:centerDrawer rightDrawerViewController:rightDrawer];
    
    drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    // 设置右边抽屉显示的占比
    drawerController.maximumRightDrawerWidth = 200.0;
    
    [self.navigationController pushViewController:drawerController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
