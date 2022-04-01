//
//  OSUnfairLockDemo.m
//  Multi-ThreadDemo
//
//  Created by Twisted Fate on 2022/4/1.
//

#import "OSUnfairLockDemo.h"
#import <os/lock.h>

@implementation OSUnfairLockDemo

- (void)test {
    
    // 初始化
    os_unfair_lock lock = OS_UNFAIR_LOCK_INIT;
    // 尝试加锁
    bool result = os_unfair_lock_trylock(&lock);
    // 加锁
    os_unfair_lock_lock(&lock);
    // 解锁
    os_unfair_lock_lock(&lock);
    
}


- (void)_saleTicket {
    [super _saleTicket];
}

- (void)_saveMoney {
    
    [super _saveMoney];
    
}

- (void)_drawMoney {
    
    [super _drawMoney];
}
@end
