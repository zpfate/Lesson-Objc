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

- (void)initBluetooth:(NSString *)devicePrefix;

- (void)startScan;

- (void)startConnectPeripheral;

- (void)stopScan;

- (void)writeValue:(NSData *)value;

- (void)setConnectBlock:(void (^ _Nonnull)(NSDictionary * _Nonnull))connectBlock;


- (void)setReceiveDataBlock:(void (^ _Nonnull)(NSData * _Nonnull))receiveDataBlock;


@end

NS_ASSUME_NONNULL_END
