//
//  BYHomeViewController.m
//  LookPiano
//
//  Created by lby on 2017/8/14.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "BYHomeViewController.h"
#import "BYMusicTypeViewController.h"
#import "BYMusicListViewController.h"
#import "BYHome.h"
#import "BYHomeCell.h"
#import "BYHTTPSessionManager.h"
#import <UIButton+WebCache.h>
#import <MMDrawerController.h>
#import "BYNavigationController.h"

@interface BYHomeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *cycleCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *cycleFlowLayout;
@property (nonatomic, strong) NSArray *cycleList;
// 定时器
@property (nonatomic, strong) NSTimer *timer;
// 热榜
@property (weak, nonatomic) IBOutlet UIButton *hotListBtn;
// 主题
@property (weak, nonatomic) IBOutlet UIButton *themeBtn;
// 类型
@property (weak, nonatomic) IBOutlet UIButton *classificationBtn;
// 连接
@property (nonatomic, weak) UIBarButtonItem *connectItem;
@property (nonatomic, strong) MMDrawerController *drawerController;
@end

static NSString *BYHomeCellId = @"BYHomeCellId";

@implementation BYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    
    [self loadCycleData];
    
    [self setupCollectionView];
    
    [self setupBtnData];
    
}

#pragma mark - PrivateMethod
- (void)setupBtnData
{
    NSString *URLString = @"api/MusicClassify/getByPid";
    
    [BYHome loadBtnDataWithURLString:URLString successBlock:^(NSArray *btnDataList) {
        
//        NSArray *dictArr = responseObject[@"obj"];
//        NSString *hotListStr = [dictArr objectAtIndex:0][@"imgUrl"];
//        NSString *themeStr = [dictArr objectAtIndex:2][@"imgUrl"];
//        NSString *classificationStr = [dictArr objectAtIndex:1][@"imgUrl"];
        [btnDataList enumerateObjectsUsingBlock:^(BYHome *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            switch ([obj.imgId integerValue])
            {
                case 1:
                    [self.hotListBtn sd_setImageWithURL:[NSURL URLWithString:obj.imgUrl] forState:UIControlStateNormal];
                    break;
                case 3:
                    [self.themeBtn sd_setImageWithURL:[NSURL URLWithString:obj.imgUrl] forState:UIControlStateNormal];
                    break;
                case 2:
                    [self.classificationBtn sd_setImageWithURL:[NSURL URLWithString:obj.imgUrl] forState:UIControlStateNormal];
                    break;
            }
        }];
    } failedBlock:^(NSError *error) {
        BYLog(@"%@",error);
    }];
}

- (void)loadCycleData
{
    NSString *URLString = @"api/carousel/listValidCarousel";
    
    [BYHome loadCycleDataWithURLString:URLString successBlock:^(NSArray *cycleList) {
        // 获取数据源数组
        self.cycleList = cycleList;
//        BYLog(@"cycleList = %@",self.cycleList);
        
        // 获取到数据源数组之后,刷新UICollectionView
        [self.cycleCollectionView reloadData];
        
        // 创建索引
        NSIndexPath *scrollToPath = [NSIndexPath indexPathForItem:0 inSection:1];
        // 让它默认就滚动中间的这一组的第0个cell
        [self.cycleCollectionView scrollToItemAtIndexPath:scrollToPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        
        // 添加定时器
        [self addTimer];
        
    } failedBlock:^(NSError *error) {
        BYLog(@"%@",error);
    }];
}

- (void)setUpNav
{
    // 引导
//    UIBarButtonItem *guidanceItem = [UIBarButtonItem itemWithImage:@"iconDisConect" highImage:@"iconDisConect" target:self action:@selector(guidanceClick)];
    
    // 语言切换
    UIBarButtonItem *languageItem = [UIBarButtonItem itemWithImage:@"icon_en" highImage:@"icon_en" target:self action:@selector(languageClick)];
    
    // 连接
//    UIBarButtonItem *connectItem = [UIBarButtonItem itemWithImage:@"iconDisConect" highImage:@"iconDisConect" target:self action:@selector(connectClick) connectSuccess:YES];
    
//    self.navigationItem.rightBarButtonItems = @[connectItem,languageItem, guidanceItem];
    UIBarButtonItem *connectItem = nil;
    if (self.connectSuccess)
    {
        connectItem = [UIBarButtonItem itemWithImage:@"iconConnect" highImage:@"iconConnect" target:self action:@selector(connectSuccessClick)];
    }
    else
    {
        connectItem = [UIBarButtonItem itemWithImage:@"iconDisConnect" highImage:@"iconDisConnect" target:self action:@selector(connectFailureClick)];
    }
    self.navigationItem.rightBarButtonItems = @[connectItem,languageItem];
}

- (void)guidanceClick
{
    BYLogFunc
}
- (void)languageClick
{
    BYLogFunc
}
- (void)connectSuccessClick
{
    BYLogFunc
}

- (void)connectFailureClick
{
    BYLogFunc
}

- (void)setupCollectionView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.cycleCollectionView.dataSource = self;
    self.cycleCollectionView.delegate = self;
    
    self.cycleCollectionView.showsHorizontalScrollIndicator = NO;
    self.cycleCollectionView.showsVerticalScrollIndicator = NO;
    self.cycleCollectionView.pagingEnabled = YES;
    self.cycleCollectionView.bounces = NO;
    
    self.cycleFlowLayout.minimumLineSpacing = 0;
    self.cycleFlowLayout.minimumInteritemSpacing = 0;
    self.cycleFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.cycleFlowLayout.itemSize = self.cycleCollectionView.bounds.size;
    
    // 通过sb去加载,所以不需要注册,重用cell直接走sb中自定义的cell
//    [self.cycleCollectionView registerClass:[BYHomeCell class] forCellWithReuseIdentifier:BYHomeCellId];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    BYLogFunc
    // 隐藏返回按钮
    self.navigationItem.hidesBackButton = YES;
}

// 热榜
- (IBAction)hotListBtnClick:(UIButton *)sender
{
    [self.navigationController pushViewController:[BYMusicTypeViewController createViewControllerWithMusicType:BYOneLevelMusicTypeHotList] animated:YES];
}

// 主题
- (IBAction)themeBtnClick:(UIButton *)sender
{
    [self.navigationController pushViewController:[BYMusicTypeViewController createViewControllerWithMusicType:BYOneLevelMusicTypeTheme] animated:YES];
}

// 类型
- (IBAction)classificationBtnClick:(UIButton *)sender
{
    [self.navigationController pushViewController:[BYMusicTypeViewController createViewControllerWithMusicType:BYOneLevelMusicTypeClassification] animated:YES];
}

#pragma mark - CollecitonView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cycleList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BYHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BYHomeCellId forIndexPath:indexPath];
    
//    NSInteger itemIndex = indexPath.item % self.cycleList.count;
//    BYHome *home = self.cycleList[itemIndex];
    
    BYHome *home = self.cycleList[indexPath.item];
    cell.home = home;
    
    return cell;
}

#pragma mark - CollecitonView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    BYHome *home = self.cycleList[indexPath.item];
        [self.navigationController pushViewController:[BYMusicListViewController createViewControllerWithMusicType:[home.imgId integerValue]] animated:YES];
    
//    [self setUpDrawerWithHome:home];
}

- (void)setUpDrawerWithHome:(BYHome *)home
{
    BYMusicListViewController *centerDrawer = [BYMusicListViewController createViewControllerWithMusicType:[home.imgId integerValue]];
    
//    BYNavigationController *centerNav = [[BYNavigationController alloc] initWithRootViewController:centerDrawer];
    
    UIViewController *rightDrawer = [[UIViewController alloc] init];
    rightDrawer.view.backgroundColor = BYRandomColor;
    
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(30, 30, 100, 30);
    btn.backgroundColor = BYRandomColor;
    [rightDrawer.view addSubview:btn];
    
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:centerDrawer rightDrawerViewController:rightDrawer];
    
    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    // 设置右边抽屉显示占比
    self.drawerController.maximumRightDrawerWidth = 200.0;
    
    [self.navigationController pushViewController:self.drawerController animated:YES];
//    [UIApplication sharedApplication].keyWindow.rootViewController = drawerController;
}

#pragma mark - CycleMethod

- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    // 把定时器添加到当前运行循环,并且调为通用模式
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

// 定时器回调方法
- (void)nextPage
{
    // 获取当前滚动到第几个cell
    NSIndexPath *visiblePath = [[self.cycleCollectionView indexPathsForVisibleItems] lastObject];
    
    NSIndexPath *scrollToPath = nil;
    // 如果是最后一页,继续向前走,走到第2组的第0个cell
    if (visiblePath.item == 2)
    {
        scrollToPath = [NSIndexPath indexPathForItem:0 inSection:2];
        
    } else
    {
        // 如果不是最后一页就滚动到下一页
        scrollToPath = [NSIndexPath indexPathForItem:visiblePath.item + 1 inSection:1];
    }
    
    [self.cycleCollectionView scrollToItemAtIndexPath:scrollToPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

// 手动滚动开始,停止定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 禁用定时器
    [self.timer invalidate];
}

// 停止拖拽,松手后调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 无降速,停止拖拽里的内容完全停止
    if (decelerate == NO)
    {
        [self addTimer];
    }
}

// 用代码动画滚动时,当滚动完一页且动画停止后调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获取当前collectionView上可视的cell的索引
    NSIndexPath *visiblePath = [[self.cycleCollectionView indexPathsForVisibleItems] lastObject];
    
    // 如果不是中间这一组的时候才去滚动
    if (visiblePath.section == 1) return;
    
    // 滚动到中间这一组的第几个cell
    NSIndexPath *scrollToPath = [NSIndexPath indexPathForItem:visiblePath.item inSection:1];
    // 无动画回到中间这一组的第visiblePath.item的那个cell
    [self.cycleCollectionView scrollToItemAtIndexPath:scrollToPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

// 手动拖拽滚动时,当cell完全停止后调用,相当于拖完一整个页面
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self addTimer];
    
    // 获取当前collectionView上面看到的cell的索引
    NSIndexPath *visiblePath = [[self.cycleCollectionView indexPathsForVisibleItems] lastObject];
    
    // 如果不是中间这一组的时候才去滚动
    if (visiblePath.section == 1) return;
    
    // 滚动到中间这一组的第几个cell
    NSIndexPath *scrollToPath = [NSIndexPath indexPathForItem:visiblePath.item inSection:1];
    // 无动画回到中间这一组的第visiblePath.item的那个cell
    [self.cycleCollectionView scrollToItemAtIndexPath:scrollToPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

@end
