//
//  ViewController.m
//  RunLoopDemo
//
//  Created by Twisted Fate on 2022/3/29.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

void observerAction(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"kCFRunLoopEntry");
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"kCFRunLoopBeforeTimers");
            break;
        case kCFRunLoopBeforeSources:
            NSLog(@"kCFRunLoopBeforeSources");
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"kCFRunLoopBeforeWaiting");
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@"kCFRunLoopAfterWaiting");
            break;
        case kCFRunLoopExit:
            NSLog(@"kCFRunLoopExit");
            break;
        default:
            break;
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 当前线程的Runloop
    NSRunLoop *currentRunloop = [NSRunLoop currentRunLoop];
    CFRunLoopRef currentRunloopRef = CFRunLoopGetCurrent();

    // 主线程的Runloop
    NSRunLoop *mainRunloop = [NSRunLoop currentRunLoop];
    CFRunLoopRef mainloopRef = CFRunLoopGetMain();

//    [self performSelector:@selector(dd) onThread:nil withObject:nil waitUntilDone:nil];
//
//    self performSelector: withObject: afterDelay:
    
    // kCFRunLoopCommonModes包含kCFRunLoopDefaultMode UITrackingRunLoopMode
    
    // activities: 监听的状态
    // order: 顺序
    // repeat 重复
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, observerAction, NULL);
    // 添加observer到RunLoop中
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
    
    CFRelease(observer);
    
    
}


@end
