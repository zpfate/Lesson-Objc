//
//  AppDelegate.m
//  AppDemo
//
//  Created by Twisted Fate on 2022/3/28.
//

#import "AppDelegate.h"
#import "EBRouter.h"
@interface AppDelegate ()


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    
    [EBRouter openURL:@"/stock/detail"];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}


@end
