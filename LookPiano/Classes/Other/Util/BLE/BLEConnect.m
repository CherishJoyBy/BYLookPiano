//
//  BLEConnect.m
//  蓝牙4.0Demo
//
//  Created by lby on 2017/4/28.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BLEConnect.h"

@interface BLEConnect ()<CBCentralManagerDelegate,CBPeripheralDelegate>

// 中央管理者
//@property (nonatomic, strong) CBCentralManager *centralManager;
// 存储的设备
@property (nonatomic, strong) NSMutableArray *peripheralArr;
// 当前扫描到的蓝牙设备
@property (nonatomic, strong) CBPeripheral *blePeripheral;
// 连接成功的蓝牙设备
@property (nonatomic, strong) CBPeripheral *linkBlePeripheral;
// 写特征
@property (nonatomic, strong) CBCharacteristic *writeCharacteristic;

@end

// 蓝牙4.0设备名
static NSString * const kBlePeripheralPrefixName = @"Tv";
// 通知服务
static NSString * const kNotifyServerUUID = @"FFE0";
// 写服务
static NSString * const kWriteServerUUID = @"FFE5";
// 通知特征值
static NSString * const kNotifyCharacteristicUUID = @"FFE4";
// 写特征值
static NSString * const kWriteCharacteristicUUID = @"FFE9";

static NSString * const BlePeripheralNotification = @"BlePeripheralNotification";
static NSString * const BlePeripheralStatusNotification = @"BlePeripheralStatusNotification";

@implementation BLEConnect

// 蓝牙连接的单例
+ (instancetype)shareBleConnect
{
//    BYLogFunc
    static BLEConnect *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BLEConnect alloc] init];
    });
    return instance;
}

// 懒加载
- (NSMutableArray *)peripheralArr
{
    if (!_peripheralArr) {
        _peripheralArr = [NSMutableArray array];
    }
    return _peripheralArr;
}

- (CBCentralManager *)centralManager
{
    if (!_centralManager)
    {
        _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return _centralManager;
}

// 开始扫描
- (void)starScan
{
//    BYLogFunc
    if (self.peripheralArr.count)
    {
        [self.peripheralArr removeAllObjects];
    }
    [self.centralManager stopScan];
//    NSLog(@"扫描设备");
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
}

// 开始连接
- (void)starLinkWithBlePeripheralName:(NSString *)blePeripheralName
{
//    BYLogFunc
    [self.peripheralArr enumerateObjectsUsingBlock:^(CBPeripheral *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"%@",obj.name);
        if ([obj.name isEqualToString: blePeripheralName])
        {
//            NSLog(@"准备连接的设备名%@",obj.name);
            [self.centralManager connectPeripheral:obj options:nil];
        }
    }];
}
// 断开连接
- (void)disconnectLink
{
    BYLogFunc
    if (self.blePeripheral)
    {
        // 取消设备连接
        [self.centralManager cancelPeripheralConnection:self.blePeripheral];
    }
    
    self.linkBlePeripheral = nil;
}


// 状态更新时调用
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
//    BYLogFunc
    switch (central.state) {
        case CBManagerStateUnknown:
        {
        }
            break;
        case CBManagerStateResetting:
        {
        }
            break;
        case CBManagerStateUnsupported:
        {
        }
            break;
        case CBManagerStateUnauthorized:
        {
        }
            break;
        case CBManagerStatePoweredOff:
        {
        }
            break;
        case CBManagerStatePoweredOn:
        {
            [self starScan];
        }
            break;
        default:
            break;
    }
}

/**
 扫描到设备

 @param central 中心管理者
 @param peripheral 扫描到的设备
 @param advertisementData 广告信息
 @param RSSI 信号强度
 */
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
//    BYLogFunc
    
//    NSLog(@"扫描到设备:%@",peripheral.name);
    // 如果不包含设备,存入设备数组
    if (![self.peripheralArr containsObject:peripheral])
    {
        // TV开头的设备发送给Unity
        if ([peripheral.name hasPrefix:kBlePeripheralPrefixName])
        {
            [self.peripheralArr addObject:peripheral];
//            NSLog(@"%@",peripheral);
        
            self.blePeripheral = peripheral;
            
            // 发现设备名,发送到连接列表并展示
            [[NSNotificationCenter defaultCenter] postNotificationName:BlePeripheralNotification object:peripheral.name];
        }
    }
}

/**
 连接失败

 @param central 中心管理者
 @param peripheral 连接失败的设备
 @param error 错误信息
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
//    NSLog(@"连接设备:%@失败",peripheral.name);
//    UnitySendMessage("PublicGameObject", "getPeripheralStatue",[@"linkFailed" UTF8String]);
    // 失败重连
//    if ([peripheral.name hasPrefix:kBlePeripheralPrefixName])
//    {
//        [self.centralManager connectPeripheral:self.blePeripheral options:nil];
//    }
}


/**
 连接断开

 @param central 中心管理者
 @param peripheral 连接断开的设备
 @param error 错误信息
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
//    NSLog(@"连接设备:%@断开",peripheral.name);
//    UnitySendMessage("PublicGameObject", "getPeripheralStatue",[@"linkDisconnect" UTF8String]);
    // 断开重连
//    if ([peripheral.name hasPrefix:kBlePeripheralPrefixName])
//    {
//        [self.centralManager connectPeripheral:self.blePeripheral options:nil];
//    }
}

/**
 连接成功

 @param central 中心管理者
 @param peripheral 连接成功的设备
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    // 连接到设备停止扫描
    [self.centralManager stopScan];
    
    // 连接设备成功,发通知给下一个控制器,改图标
    [[NSNotificationCenter defaultCenter] postNotificationName:BlePeripheralStatusNotification object:nil];
    
//    NSLog(@"连接设备:%@成功",peripheral.name);
    self.linkBlePeripheral = peripheral;
    
    // 设置代理
    peripheral.delegate = self;
    // 扫描所有服务
    [peripheral discoverServices:nil];
}

/**
 扫描到服务

 @param peripheral 服务对应的设备
 @param error 扫描错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    // 遍历所有的服务
    for (CBService *service in peripheral.services)
    {
//        NSLog(@"服务:%@",service.UUID.UUIDString);
        // 获取对应的服务
        if ([service.UUID.UUIDString isEqualToString:kWriteServerUUID] || [service.UUID.UUIDString isEqualToString:kNotifyServerUUID])
        {
            // 根据服务去扫描特征
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}

/**
 扫描到对应的特征

 @param peripheral 设备
 @param service 特征对应的服务
 @param error 错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    // 遍历所有的特征
    for (CBCharacteristic *characteristic in service.characteristics)
    {
//        NSLog(@"特征值:%@",characteristic.UUID.UUIDString);
        // 获取对应的特征
        if ([characteristic.UUID.UUIDString isEqualToString:kWriteCharacteristicUUID])
        {
            self.writeCharacteristic = characteristic;
        }
        if ([characteristic.UUID.UUIDString isEqualToString:kNotifyCharacteristicUUID])
        {
            // 监听通知信息
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            //            [peripheral readValueForCharacteristic:characteristic];
        }
    }
}

/**
 根据特征读到数据

 @param peripheral 读取到数据对应的设备
 @param characteristic 特征
 @param error 错误信息
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(nonnull CBCharacteristic *)characteristic error:(nullable NSError *)error
{
    if ([characteristic.UUID.UUIDString isEqualToString:kNotifyCharacteristicUUID])
    {
        NSData *data = characteristic.value;
        
        if (data.length > 1)
        {
            NSMutableArray *arrM = [NSMutableArray array];
            Byte *dataByte = (Byte *)data.bytes;
            
            for (NSInteger i = 0; i < data.length; i++)
            {
                // 按下首字节
                Byte downByte = 159;
                // 抬起首字节
                Byte upByte = 143;
                // 钢琴默认广播的字节
                Byte defaultByte = 254;
                
                if (dataByte[i] == downByte || dataByte[i] == upByte)
                {
                    if (data.length - i >= 3 && dataByte[i + 1] != defaultByte && dataByte[i + 2] != defaultByte)
                    {
                        for (NSInteger j = 0; j < 3; j++)
                        {
                            [arrM addObject:[NSString stringWithFormat:@"%hhd",dataByte[i + j]]];
                        }
                    }
                }
            }
            NSDictionary *dict = @{
                                   @"deviceData" : arrM
                                   };
            
            NSString *jsonStr = [self dictionaryToJson:dict];
            
            NSLog(@"jsonStr = %@",jsonStr);
            
//            UnitySendMessage("PublicGameObject", "getCharacteristicMessage",[jsonStr UTF8String]);
        }
    }
}

// 字典转json字符串
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/**
 给钢琴写数据
 
 @param instructionArr 指令数组
 @param instructionLength 指令长度
 */
- (void)writeDataWithInstructionArr:(Byte[])instructionArr withInstructionLength:(int)instructionLength
{
    NSData *writeData = [NSData dataWithBytes:instructionArr length:instructionLength];
    [self.linkBlePeripheral writeValue:writeData forCharacteristic:self.writeCharacteristic type:CBCharacteristicWriteWithResponse];
}

@end
