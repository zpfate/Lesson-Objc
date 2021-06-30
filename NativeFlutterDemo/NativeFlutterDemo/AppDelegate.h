//
//  AppDelegate.h
//  NativeFlutterDemo
//
//  Created by Twisted Fate on 2021/5/27.
//

#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) FlutterBasicMessageChannel *channel;

@property (nonatomic, strong) FlutterEngine *flutterEngine;

@end

