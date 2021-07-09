//
//  RRBluetoothUtil.m
//  FlutterBLEDemo
//
//  Created by Twisted Fate on 2021/7/9.
//

#import "RRBluetoothUtil.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface RRBluetoothUtil ()<CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *manager;

@property (nonatomic, strong) CBPeripheral *peripheral;

@end

@implementation RRBluetoothUtil

+ (instancetype)shared {
    
    static RRBluetoothUtil *util = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = [[RRBluetoothUtil alloc] init];
    });
    return util;
}

/// 初始化蓝牙
- (void)initBluetooth {
    /// 初始化中心设备
    self.manager = [[CBCentralManager alloc]  initWithDelegate:self queue:nil];
}

/// 扫描设备
- (void)startScan {
    if (self.manager.state == CBManagerStatePoweredOn) {
        /// 扫描设备
        [self.manager scanForPeripheralsWithServices:nil options:nil];
    }
}

/// 链接设备
- (void)startConnectPeripheral {
    
    if (self.peripheral.state == CBPeripheralStateDisconnected) {
        [self.manager connectPeripheral:self.peripheral options:nil];
    }
}

/// 停止扫描
- (void)stopScan {
    if (self.manager.isScanning) {
        [self.manager stopScan];
    }
}

/// 发现外设服务
- (void)discoverServices {
    
    /// FFFF 花纹尺
    /// FFE0 巡检工具
    if (self.peripheral.state == CBPeripheralStateConnected) {
        self.peripheral discoverServices:<#(nullable NSArray<CBUUID *> *)#>
    }
}

/// 发现服务下的特征值
- (void)discoverCharacteristics {
    
    /// 花纹尺的时候读取特征值FF00
    
    if (self.peripheral.state == CBPeripheralStateConnected) {
        self.peripheral discoverCharacteristics:nil forService:<#(nonnull CBService *)#>
    }
}

- (void)readValue {
    /**
     前缀 faaf
     中间包体为偶数
     结尾 feef
     */
    
}


#pragma mark -- CBCentralManagerDelegate

/// 中心设备的状态变更
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    switch (central.state) {
        case CBManagerStateUnknown:
            /// 未知状态
            break;
        case CBManagerStatePoweredOn:
            /// 蓝牙打开状态
            break;
        case CBManagerStatePoweredOff:
            /// 蓝牙关闭状态
            break;
        case CBManagerStateUnauthorized:
            /// 蓝牙未授权
            break;
        case CBManagerStateUnsupported:
            /// 不支持BLE
            break;
        case CBManagerStateResetting:
            break;
        default:
            break;
    }
}

/// 发现外设
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    
    NSString *peripheralName = peripheral.name;
    /// 智慧部门那边目前的规则是扫描到第一个就链接
    if ([peripheralName hasPrefix:@"zhilun_"]) {
        self.peripheral = peripheral;
        
        [self stopScan];
    }
}

/// 链接上外设
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
    
}

#pragma mark -- CBPeripheralDelegate



@end
