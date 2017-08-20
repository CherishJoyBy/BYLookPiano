//
//  BLEConnect.h
//  蓝牙4.0Demo
//
//  Created by lby on 2017/4/28.
//  Copyright © 2017年 lby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BLEConnect : NSObject
// 中央管理者
@property (nonatomic, strong) CBCentralManager *centralManager;

/**
 创建蓝牙连接的单例

 @return 蓝牙连接的单例对象
 */
+ (instancetype)shareBleConnect;

/**
 开始扫描
 */
- (void)starScan;

/**
 开始连接

 @param blePeripheralName 蓝牙设备名
 */
- (void)starLinkWithBlePeripheralName:(NSString *)blePeripheralName;


/**
 断开连接
 */
- (void)disconnectLink;

/**
 给钢琴写数据

 @param instructionArr 指令数组
 @param instructionLength 指令长度
 */
- (void)writeDataWithInstructionArr:(Byte[])instructionArr withInstructionLength:(int)instructionLength;

@end
