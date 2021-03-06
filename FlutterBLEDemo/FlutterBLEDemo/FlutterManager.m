//
//  FlutterManager.m
//  FlutterBLEDemo
//
//  Created by Twisted Fate on 2021/7/13.
//

#import "FlutterManager.h"
#import "RRBluetoothUtil.h"
@interface FlutterManager ()


@end

@implementation FlutterManager


+ (instancetype)shared {
    static FlutterManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[FlutterManager alloc] init];
    });
    return shared;
}

- (void)initFlutterEngine {
    
    self.engine = [[FlutterEngine alloc] initWithName:@"com.zhilunkeji.flutter.engine"];
    [self.engine run];
    self.messageChannel = [FlutterBasicMessageChannel messageChannelWithName:@"com.zhilunkeji.message.channel" binaryMessenger:self.engine.binaryMessenger];
    [GeneratedPluginRegistrant registerWithRegistry:self.engine];
    [self.messageChannel setMessageHandler:^(id  _Nullable message, FlutterReply  _Nonnull callback) {
        NSDictionary *dict = (NSDictionary *)message;

    }];

    self.bluetoothMessageChannel = [FlutterBasicMessageChannel messageChannelWithName:@"com.zhilunkeji.messagechannel.bluetooth" binaryMessenger:self.engine.binaryMessenger];
    
    [self.bluetoothMessageChannel setMessageHandler:^(id  _Nullable message, FlutterReply  _Nonnull callback) {
        
        /// 接收到flutter通信
        NSDictionary *dict = (NSDictionary *)message;
        if ([dict[@"type"] isEqualToString:@"bluetooth"]) {
            /// 蓝牙
            NSString *methodName = dict[@"method"];
            RRBluetoothUtil *bluetoothUtil = [RRBluetoothUtil shared];
            if ([methodName isEqualToString:@"init"]) {
                [bluetoothUtil initBluetooth:dict[@"prefix"]];
                [bluetoothUtil setConnectBlock:^(NSDictionary * _Nonnull res) {
                    callback(res);
                }];

            } else if ([methodName isEqualToString:@"startConnect"]){
                [bluetoothUtil startConnectPeripheral];
            } else if ([methodName isEqualToString:@"sendData"]) {
                FlutterStandardTypedData *data = dict[@"data"];
                [bluetoothUtil writeValue:data.data];
            }
        }
    }];
}


#pragma mark -- Get



@end
