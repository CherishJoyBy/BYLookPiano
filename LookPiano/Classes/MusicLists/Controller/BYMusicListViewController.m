//
//  BYMusicListViewController.m
//  LookPiano
//
//  Created by lby on 2017/8/14.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "BYMusicListViewController.h"
#import "BYMusicListCell.h"
#import "BYMusicListRightViewController.h"
#import <MMDrawerController.h>
#import <UIViewController+MMDrawerController.h>
#import "BYMusicPlayerViewController.h"


@interface BYMusicListViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *musicListsCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *musicListFlowLayout;
@property (weak, nonatomic) IBOutlet UIView *rightChooseView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;

@end

static NSString *BYMusicListCellId = @"BYMusicListCellId";
@implementation BYMusicListViewController

#pragma mark - CycleLife
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self setupCollectionView];
    
    [self setUpTwoLevelMusicType];
    
    [self setUpRightView];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
//}

#pragma mark - PrivateMethod
- (void)setUpRightView
{
//     UIView *view = [[UIView alloc] initWithFrame:CGRectMake(568, 0, 200, 320)];
    self.rightChooseView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.rightChooseView];
}

- (void)setUpNav
{
    // 筛选
    UIBarButtonItem *chooseItem = [UIBarButtonItem itemWithImage:@"icon_shai" highImage:@"icon_shai" target:self action:@selector(chooseClick)];

    UIBarButtonItem *connectItem;
    if (self.connectSuccess)
    {
        connectItem = [UIBarButtonItem itemWithImage:@"iconConnect" highImage:@"iconConnect" target:self action:@selector(connectSuccessClick)];
    }
    else
    {
        connectItem = [UIBarButtonItem itemWithImage:@"iconDisConnect" highImage:@"iconDisConnect" target:self action:@selector(connectFailureClick)];
    }
    self.navigationItem.rightBarButtonItems = @[connectItem,chooseItem];
}

- (IBAction)chooseFinish:(UIButton *)sender
{
//    [button1.layer setBorderColor:[UIColor redColor].CGColor];
//    [button1.layer setBorderWidth:1];
//    [button1.layer setMasksToBounds:YES];
    
    UIButton *btn = [[UIButton alloc] init];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    
}

- (IBAction)reChoose:(UIButton *)sender
{
}

- (void)chooseClick
{
    BYLogFunc
//    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    
    // 该方法可以设置从右到左移动的动画
//    [UIView animateWithDuration:0.2 animations:^{
//        self.rightChooseView.frame = CGRectMake(368, 0, 200, 320);
//        //        self.navigationController.navigationBar.alpha = 0;
//    }];
    
     // 设置约束 和 按钮状态
    if (self.leftConstraint.constant == 0)
    {
        // 目前显示的是list界面, 点击按钮后要切换为right界面
        self.leftConstraint.constant = - 220;
    }
    else
    {
        // 目前显示的是right界面, 点击按钮后要切换为list界面
        self.leftConstraint.constant = 0;
    }
    
    [self.view bringSubviewToFront:self.rightChooseView];
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        // 强制刷新 : 让最新设置的约束值马上应用到UI控件上
        // 会刷新到self.view内部的所有子控件
        [self.view layoutIfNeeded];
    }];
}

- (void)connectFailureClick
{
    BYLogFunc
}

- (void)connectSuccessClick
{
    BYLogFunc
}

- (void)setUpTwoLevelMusicType
{
    switch (self.twoLevelMusicType) {
            
        case BYTwoLevelMusicTypePop:
            
            break;
        case BYTwoLevelMusicTypeChildren:
            
            break;
        case BYTwoLevelMusicTypeAge:
            
            break;
    }
}

+ (instancetype)createViewControllerWithMusicType:(BYTwoLevelMusicType)twoLevelMusicType
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:NSStringFromClass(self) bundle:nil];
    
    BYMusicListViewController *musicTypeVc = [sb instantiateInitialViewController];
    musicTypeVc.twoLevelMusicType = twoLevelMusicType;
    
    return musicTypeVc;
}

- (void)setupCollectionView
{
    self.musicListsCollectionView.dataSource = self;
    self.musicListsCollectionView.delegate = self;
    
    self.musicListsCollectionView.showsHorizontalScrollIndicator = NO;
    self.musicListsCollectionView.showsVerticalScrollIndicator = NO;
    self.musicListsCollectionView.pagingEnabled = YES;
    self.musicListsCollectionView.bounces = NO;
    
    self.musicListFlowLayout.minimumLineSpacing = 10;
    self.musicListFlowLayout.minimumInteritemSpacing = 10;
    self.musicListFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    CGSize collectionViewSize = self.musicListsCollectionView.bounds.size;
    self.musicListFlowLayout.itemSize = CGSizeMake((collectionViewSize.width - 50) / 6, (collectionViewSize.height - 10)/ 2);
}

#pragma mark - CollecitonView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 63;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BYMusicListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BYMusicListCellId forIndexPath:indexPath];
    
//    cell.indexPath = indexPath;
    
    cell.backgroundColor = BYRandomColor;

    return cell;
}

#pragma mark - CollecitonView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"BYMusicPlayerViewController" bundle:nil];
    BYMusicPlayerViewController *musicPlayerVc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:musicPlayerVc animated:YES];
}

@end
