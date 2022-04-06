//
//  SemaphoreDemo.m
//  Multi-ThreadDemo
//
//  Created by Twisted Fate on 2022/4/6.
//

#import "SemaphoreDemo.h"

@interface SemaphoreDemo ()
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (nonatomic, strong) dispatch_semaphore_t ticketSemaphore;
@property (nonatomic, strong) dispatch_semaphore_t moneySemaphore;

@end

@implementation SemaphoreDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        _semaphore = dispatch_semaphore_create(5);
        _ticketSemaphore = dispatch_semaphore_create(1);
        _moneySemaphore = dispatch_semaphore_create(1);

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
            
            // 如果信号量的值<=0,当前线程就会进入休眠等待(直到信号量的值>0)
            // 如果信号的值>0,就减一,然后往下执行代码
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
            sleep(1);
            NSLog(@"test ---- %@", [NSThread currentThread]);
            
            // 让信号值+1
            dispatch_semaphore_signal(self.semaphore);
            
        }] start];
    }
}


- (void)_saleTicket {
    dispatch_semaphore_wait(self.ticketSemaphore, DISPATCH_TIME_FOREVER);
    [super _saleTicket];
    dispatch_semaphore_signal(self.ticketSemaphore);
}

- (void)_saveMoney {
    dispatch_semaphore_wait(self.moneySemaphore, DISPATCH_TIME_FOREVER);
    [super _saveMoney];
    dispatch_semaphore_signal(self.moneySemaphore);
}

- (void)_drawMoney {
    dispatch_semaphore_wait(self.moneySemaphore, DISPATCH_TIME_FOREVER);
    [super _drawMoney];
    dispatch_semaphore_signal(self.moneySemaphore);
}


@end
