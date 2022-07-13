//
//  AppDelegate.m
//  MediatorDemo
//
//  Created by Twisted Fate on 2022/7/12.
//

#import "AppDelegate.h"
#import "HomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    HomeViewController *homeVC = [HomeViewController new];
    
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    self.window.rootViewController = naVC;
    
    return YES;
}





@end
