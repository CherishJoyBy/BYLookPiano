//
//  BYConnectViewController.m
//  LookPiano
//
//  Created by lby on 2017/8/14.
//  Copyright © 2017年 llk. All rights reserved.
//

#import "BYConnectViewController.h"
#import "BYHomeViewController.h"
#import "BLEConnect.h"

@interface BYConnectViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *connectTableView;
// 连接成功的蓝牙设备
@property (nonatomic, strong) CBPeripheral *linkBlePeripheral;
@property (nonatomic, strong) NSMutableArray *blePeripheralArr;
@property (nonatomic, assign) BOOL connectSuccess;

@end

static NSString * const BYConnectCellId = @"BYConnectCell";
static NSString * const BlePeripheralNotification = @"BlePeripheralNotification";
static NSString * const BlePeripheralStatusNotification = @"BlePeripheralStatusNotification";

@implementation BYConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    BYLogFunc
    
    [self setUpBLE];
    
    [self setUpTableView];
    
    [self enterConnectBtnClick];
}

#pragma mark - PrivateMethod
- (void)setUpTableView
{
    self.connectTableView.dataSource = self;
    self.connectTableView.delegate = self;
    
    self.connectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.connectTableView addSubview:[[UIView alloc] init]];
}

- (void)setUpBLE
{
    // 开始扫描
    [[BLEConnect shareBleConnect] centralManager];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getBlePeripheralNotification:) name:BlePeripheralNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getBlePeripheralStatusNotification:) name:BlePeripheralStatusNotification object:nil];
}

#pragma mark - NotificationMethod
// 收到蓝牙设备通知的处理
- (void)getBlePeripheralNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:BlePeripheralNotification])
    {
        BYLog(@"notification.object = %@",notification.object);
        NSString *notificationBlePeripheralName = notification.object;
        // 数组中有数据时
        if (self.blePeripheralArr.count)
        {
            // 遍历
            [self.blePeripheralArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                // 收到的通知设备名不存在数组中,则加入数组,存在则移除
                if ([obj isEqualToString:notificationBlePeripheralName])
                {
                    [self.blePeripheralArr removeObject:obj];
                }
                else
                {
                    [self.blePeripheralArr addObject:notificationBlePeripheralName];
                }
            }];
        }
        else
        {
            //第一次进入,数组中没有数据
            [self.blePeripheralArr addObject:notificationBlePeripheralName];
        }
        // 刷新列表
        [self.connectTableView reloadData];
        
//        [self.blePeripheralArr removeAllObjects];
//        [self.blePeripheralArr addObject:notificationBlePeripheralName];
//        [self.connectTableView reloadData];        
    }
}

// 收到蓝牙设备通知的处理
- (void)getBlePeripheralStatusNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:BlePeripheralStatusNotification])
    {
        // 连接成功
        self.connectSuccess = YES;
    }
}

// 直接进入
- (IBAction)enterConnectBtnClick
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"BYHomeViewController" bundle:nil];
    BYHomeViewController *homeVc = [sb instantiateInitialViewController];
    homeVc.connectSuccess = NO;
    
    [self.navigationController pushViewController:homeVc animated:YES];
}

- (IBAction)reScanBtnClick
{
    if (self.connectSuccess)
    {
        // 断开连接
        [[BLEConnect shareBleConnect] disconnectLink];
    }
    // 重新扫描
    [self.blePeripheralArr removeAllObjects];
    [[BLEConnect shareBleConnect] starScan];
}


#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    BYLog(@"%zd",self.blePeripheralArr.count);
    return self.blePeripheralArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BYConnectCellId];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BYConnectCellId];
    }
    
    if (self.blePeripheralArr.count)
    {
        NSString *peripheralName = self.blePeripheralArr[indexPath.row];
        BYLog(@"%@",self.blePeripheralArr);
        
        cell.textLabel.text = peripheralName;
        cell.textLabel.textColor = [UIColor blackColor];
//        self.connectTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString * peripheralName = cell.textLabel.text;
    BYLog(@"选中的cell的名字%@",peripheralName);
    
    // 连接对应蓝牙设备
    [[BLEConnect shareBleConnect] starLinkWithBlePeripheralName:peripheralName];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"BYHomeViewController" bundle:nil];
    BYHomeViewController *homeVc = [sb instantiateInitialViewController];
    homeVc.connectSuccess = self.connectSuccess;
    [self.navigationController pushViewController:homeVc animated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - LazyLoad
- (NSMutableArray *)blePeripheralArr
{
    if (_blePeripheralArr == nil)
    {
        _blePeripheralArr = [NSMutableArray array];
    }
    return _blePeripheralArr;
}

@end
