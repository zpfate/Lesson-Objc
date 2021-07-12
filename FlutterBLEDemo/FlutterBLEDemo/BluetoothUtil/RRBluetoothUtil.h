//
//  RRBluetoothUtil.h
//  FlutterBLEDemo
//
//  Created by Twisted Fate on 2021/7/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//typedef NS_ENUM(NSUInteger, RRBluetoothUtilType) {
//    RRBluetoothUtilTypeRuler,
//    <#MyEnumValueB#>,
//    <#MyEnumValueC#>,
//};


@interface RRBluetoothUtil : NSObject

+ (instancetype)shared;

- (void)initBluetooth;

- (void)startScan;

- (void)startConnectPeripheral;

- (void)stopScan;

- (void)discoverServices;

- (void)discoverCharacteristics;

@end

NS_ASSUME_NONNULL_END
