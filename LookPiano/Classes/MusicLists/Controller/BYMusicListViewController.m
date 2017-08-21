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
#import "BYRightChooseView.h"


@interface BYMusicListViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *musicListsCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *musicListFlowLayout;
//@property (weak, nonatomic) IBOutlet UIView *rightChooseView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
//@property (nonatomic, weak) UIImageView *shadowView;
@property (nonatomic, weak) UIView *shadowView2;
@property (nonatomic, weak) BYRightChooseView *rightChooseView;

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

#pragma mark - PrivateMethod
- (void)setUpRightView
{
    // 遮罩imageView
//    UIImageView *shadowView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 568, 320)];
    UIView *shadowView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 568, 320)];
    self.shadowView2 = shadowView2;
    self.shadowView2.userInteractionEnabled = YES;
//    self.shadowView2.backgroundColor = [UIColor blackColor];
    self.shadowView2.alpha = 0;
//    self.shadowView2.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    
    UITapGestureRecognizer *tapGesturRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shadowViewTapClick:)];
    tapGesturRecognizer.delegate = self;
    [shadowView2 addGestureRecognizer:tapGesturRecognizer];
    
    // 筛选View
    BYRightChooseView *rightChooseView = [BYRightChooseView viewFromXib];
    self.rightChooseView = rightChooseView;
    self.rightChooseView.frame = CGRectMake(568, 0, 220, 320);
    self.rightChooseView.backgroundColor = [UIColor whiteColor];
    
//    UITapGestureRecognizer *tapGesturRecognizerChoose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseViewTapClick:)];
//    [rightChooseView addGestureRecognizer:tapGesturRecognizerChoose];
    
//    self.shadowView = shadowView;
//    [self.shadowView  addSubview:self.rightChooseView];
    [self.shadowView2  addSubview:self.rightChooseView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.shadowView2];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.rightChooseView])
    {
        return NO;
    }
    return YES;
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
    
}

- (IBAction)reChoose:(UIButton *)sender
{
    BYLogFunc
}

- (void)chooseClick
{
    BYLogFunc
    
    [UIView animateWithDuration:0.2 animations:^{
        self.rightChooseView.frame = CGRectMake(348, 0, 220, 320);
    }];
//    self.shadowView.alpha = 1;
//    self.shadowView.image = [UIImage imageNamed:@"bg"];
//    self.shadowView2.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256)/255.0) green:((float)arc4random_uniform(256)/255.0) blue:((float)arc4random_uniform(256)/255.0) alpha:0.6];
    self.shadowView2.alpha = 0.6;
    
//    [self setBlurEffect:self.shadowView];
}

- (void)setBlurEffect:(UIImageView *)imgView
{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    blurEffectView.frame = imgView.frame;
    [self.view addSubview:blurEffectView];
}

- (void)shadowViewTapClick:(id)tap
{
    BYLogFunc
//     self.shadowView.alpha = 0;
    self.shadowView2.alpha = 0;
//    self.shadowView2.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    self.shadowView2.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256)/255.0) green:((float)arc4random_uniform(256)/255.0) blue:((float)arc4random_uniform(256)/255.0) alpha:0];
    [UIView animateWithDuration:0.2 animations:^{
        self.rightChooseView.frame = CGRectMake(568, 0, 220, 320);
    }];
}

//- (void)chooseViewTapClick:(id)tap
//{
//    // 主要为了屏蔽父视图的点击事件
//    BYLogFunc
//}

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
