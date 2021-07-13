//
//  FlutterManager.h
//  FlutterBLEDemo
//
//  Created by Twisted Fate on 2021/7/13.
//

#import <Foundation/Foundation.h>
#import <FlutterPluginRegistrant/GeneratedPluginRegistrant.h>

NS_ASSUME_NONNULL_BEGIN

@interface FlutterManager : NSObject
@property (nonatomic, strong) FlutterEngine *engine;
@property (nonatomic, strong) FlutterBasicMessageChannel *messageChannel;
+ (instancetype)shared;
- (void)initFlutterEngine;
@end

NS_ASSUME_NONNULL_END
