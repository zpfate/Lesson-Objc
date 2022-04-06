//
//  ViewController.m
//  Multi-ThreadDemo
//
//  Created by Twisted Fate on 2022/3/31.
//

#import "ViewController.h"
#import "BaseDemo.h"
#import "Locks/OSSpinLockDemo.h"
#import "Locks/OSUnfairLockDemo.h"
#import "Locks/PthreadMutexDemo.h"
#import "Locks/MutexConditionDemo.h"
#import "Locks/NSLockDemo.h"
#import "Locks/NSConditionDemo.h"
#import "Locks/NSConditionLockDemo.h"
#import "Locks/SemaphoreDemo.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self sync];
    
//    [self gcdGroup];

    SemaphoreDemo *demo = [[SemaphoreDemo alloc] init];
//    [demo ticketTest];
//    NSLog(@"----------------");
//    [demo moneyTest];
    
    [demo otherTest];
}




- (void)testPerformSelector {
    
    // Runloop没有启动
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务1---");
        [self performSelector:@selector(testTask) withObject:nil afterDelay:0];
        NSLog(@"任务3---");
    });
}

- (void)testTask {
    NSLog(@"任务2---");

}


// GCD任务组
- (void)gcdGroup {
    
    dispatch_group_t group = dispatch_group_create();
    // 创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("group", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务1---%@", [NSThread currentThread]);
        }
    });
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务2---%@", [NSThread currentThread]);
        }
    });
    
    // 等前面的任务执行完毕后,自动执行
//    dispatch_group_notify(group, queue, ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            for (int i = 0; i < 5; i++) {
//                NSLog(@"任务2---%@", [NSThread currentThread]);
//            }
//        });
//    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            for (int i = 0; i < 5; i++) {
                NSLog(@"任务3---%@", [NSThread currentThread]);
            }
    });
}

// 死锁
- (void)lockSync {
    NSLog(@"执行任务1------");
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"执行任务2------");
    });
    
    NSLog(@"执行任务3------");
}


- (void)sync {
    
    dispatch_queue_t queue = dispatch_queue_create("sync", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"------%@", [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"*****%@", [NSThread currentThread]);
        }
    });
    
}


@end
