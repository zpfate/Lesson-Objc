//
//  AppDelegate.m
//  NativeFlutterDemo
//
//  Created by Twisted Fate on 2021/5/27.
//

#import "AppDelegate.h"
#import <GeneratedPluginRegistrant.h>

static NSString *const _kReloadChannelName = @"reload";

@interface AppDelegate ()



@property (nonatomic, strong) FlutterViewController *controller;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /// 运行flutter engine
    self.flutterEngine = [[FlutterEngine alloc] initWithName:@"my flutter engine"];
    [self.flutterEngine run];
        
    self.controller = [[FlutterViewController alloc] initWithEngine:self.flutterEngine nibName:nil bundle:nil];
    
    /// 链接插件
    [GeneratedPluginRegistrant registerWithRegistry:self.flutterEngine];
    
    self.channel = [[FlutterBasicMessageChannel alloc] initWithName:_kReloadChannelName binaryMessenger:self.flutterEngine.binaryMessenger codec:FlutterStringCodec.sharedInstance];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


@end
