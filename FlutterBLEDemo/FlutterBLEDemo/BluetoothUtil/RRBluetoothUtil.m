//
//  RRBluetoothUtil.m
//  FlutterBLEDemo
//
//  Created by Twisted Fate on 2021/7/9.
//

#import "RRBluetoothUtil.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "FlutterManager.h"
@interface RRBluetoothUtil ()<CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *manager;

@property (nonatomic, strong) CBPeripheral *peripheral;

@property (nonatomic, strong) CBCharacteristic *writeCBCharacteristic;

@property (nonatomic, copy) void(^connectBlock)(NSDictionary *res);

@property (nonatomic, copy) void(^receiveDataBlock)(NSData *value);

@property (nonatomic, strong) NSString *devicePrefix;
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
- (void)initBluetooth:(NSString *)devicePrefix {
    self.devicePrefix = devicePrefix;
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
    
    if (self.peripheral && self.peripheral.state == CBPeripheralStateDisconnected) {
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
        self.peripheral.delegate = self;
        [self.peripheral discoverServices:nil];
    } else {
        [self startConnectPeripheral];
    }
}

/// 发现服务下的特征值
- (void)discoverCharacteristics:(CBService *)service {
    /// 花纹尺的时候读取特征值FF00
    if (self.peripheral.state == CBPeripheralStateConnected) {
        CBUUID *rulerId = [CBUUID UUIDWithString:@"FF00"];
        [self.peripheral discoverCharacteristics:@[rulerId] forService:service];
    }
}

///
- (void)disconnect {
    [self.manager cancelPeripheralConnection:self.peripheral];
}

- (void)readValue {
    /**
     前缀 faaf
     中间包体为偶数
     结尾 feef
     */
    
}

- (void)writeValue:(NSData *)value {
    
    [self.peripheral writeValue:value forCharacteristic:self.writeCBCharacteristic type:CBCharacteristicWriteWithResponse];
}


- (void)setReceiveDataBlock:(void (^)(NSData * _Nonnull))receiveDataBlock {
    _receiveDataBlock = receiveDataBlock;
}


/**
 *  code :
 *  10000  成功
 *  10001 无蓝牙权限
 *  10002 蓝牙未打开
 *  10003 链接失败
 *  10004 该设备不支持蓝牙
 *
 *  10009 未知错误
 *  data : 返回数据
 */

#pragma mark -- CBCentralManagerDelegate

/// 中心设备的状态变更
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
    switch (central.state) {
      
        case CBManagerStatePoweredOn:
            /// 蓝牙打开状态
            [self startScan];
            break;
        case CBManagerStateUnauthorized:
            /// 蓝牙未授权
            [self handleConnect:10001];
            break;
        case CBManagerStatePoweredOff:
            /// 蓝牙关闭状态
            [self handleConnect:10002];
            break;
        case CBManagerStateUnsupported:
            /// 不支持BLE
            [self handleConnect:10004];
            break;
        case CBManagerStateResetting:
            break;
        case CBManagerStateUnknown:
            /// 未知状态
            [self handleConnect:10009];
            break;
        default:
            break;
    }
}

- (void)handleConnect:(NSInteger)code {
    if (self.connectBlock) {
        self.connectBlock(@{@"code": @(code)});
    }
}

/// 发现外设
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    
    NSString *peripheralName = peripheral.name;
    NSLog(@"scan peripheral name = %@, localName = %@", peripheralName, advertisementData[CBAdvertisementDataLocalNameKey]);
    /// 智慧部门那边目前的规则是扫描到第一个就链接
    if ([peripheralName hasPrefix:self.devicePrefix]) {
        /// @"zhilun_"
        self.peripheral = peripheral;
        /// 扫描应该链接的设备就停止扫描
        [self stopScan];
        [self startConnectPeripheral];
    }
}

/// 链接上外设
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {

    NSLog(@"connect success, peripheral name = %@", peripheral.name);
    [self handleConnect:10000];
    [self discoverServices];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    [self handleConnect:10005];
}

/// 链接外设失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    [self handleConnect:10003];
    NSLog(@"connect failed, error = %@", error);
}

#pragma mark -- CBPeripheralDelegate

/// 发现服务
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (!error) {
        for (CBService *service in peripheral.services) {
            
            NSString *uuidString = service.UUID.UUIDString;
            if ([uuidString isEqualToString:@"FFFF"]) {
                /// 花纹尺特征值
                [peripheral discoverCharacteristics:nil forService:service];
            } else if ([uuidString isEqualToString:@"FFE0"]) {
                [peripheral discoverCharacteristics:nil forService:service];
            }
        }
    } else {
        NSLog(@"discover service failed, error = %@", error);
    }
}

/// 发现服务下特征值
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (!error) {
        /// 发现特征值
        for (CBCharacteristic *characteristic in service.characteristics) {
            
            NSString *uuidString = characteristic.UUID.UUIDString;
            if ([uuidString isEqualToString:@"FF00"]) {
                /// 花纹尺的特征
                [peripheral setNotifyValue:YES forCharacteristic:characteristic];
                break;
            }
            if (characteristic.properties & CBCharacteristicPropertyWrite && characteristic.properties & CBCharacteristicPropertyRead && characteristic.properties & CBCharacteristicPropertyNotify &&
                (characteristic.properties & CBCharacteristicPropertyNotify ||
                 characteristic.properties & CBCharacteristicPropertyIndicate)
                ) {
                self.writeCBCharacteristic = characteristic;
            }
        }
    } else {
        NSLog(@"discover characteristics for service %@ failed, error = %@", service, error);
    }
}

/// 写入特征值时回调
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
}

/// 收到特征值改变
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
    NSData *value = characteristic.value;
    FlutterStandardTypedData *data = [FlutterStandardTypedData typedDataWithBytes:value];
    [[FlutterManager shared].bluetoothMessageChannel sendMessage:@{@"data":data}];
    
}




- (int)bytesTointFromData:(NSData *)data range:(NSRange)range {
    
    Byte bytes[range.length];
    [data getBytes:bytes range:range];
    int length = [self bytesToInt:bytes count:(int)range.length];
    return length;
}

- (int)bytesToInt:(Byte[])b count:(int) count{
    int mask=0xff;
    int temp=0;
    int n=0;
    for(int i=0; i<count; i++){
        n<<=8;
        temp=b[i]&mask;
        n|=temp;
    }
    return n;
}

@end
