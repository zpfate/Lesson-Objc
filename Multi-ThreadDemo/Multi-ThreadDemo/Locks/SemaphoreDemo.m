//
//  SemaphoreDemo.m
//  Multi-ThreadDemo
//
//  Created by Twisted Fate on 2022/4/6.
//

#import "SemaphoreDemo.h"

@interface SemaphoreDemo ()
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@end

@implementation SemaphoreDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _semaphore = dispatch_semaphore_create(5);
    }
    return self;
}

- (void)test {
    // 信号量初始值
    int value = 1;
    // 初始化信号量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(value);
    // 如果信号量的值<=0,当前线程就会进入休眠等待(直到信号量的值>0)
    // 如果信号的值>0,就减一,然后往下执行代码
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    // 让信号量的值-1
    dispatch_semaphore_signal(semaphore);
}

- (void)otherTest {
    for (int i = 0; i < 20; i++) {
        [[[NSThread alloc] initWithBlock:^{
                    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
                    sleep(1);
                    NSLog(@"test ---- %@", [NSThread currentThread]);
            dispatch_semaphore_signal(self.semaphore);
                }] start];
    }
}


//- (void)_saleTicket {
//    [_ticketLock lock];
//    [super _saleTicket];
//    [_ticketLock unlock];
//}
//
//- (void)_saveMoney {
//    [_moneyLock lock];
//    [super _saveMoney];
//    [_moneyLock unlock];
//}
//
//- (void)_drawMoney {
//    [_moneyLock lock];
//    [super _drawMoney];
//    [_moneyLock unlock];
//
//}


@end
