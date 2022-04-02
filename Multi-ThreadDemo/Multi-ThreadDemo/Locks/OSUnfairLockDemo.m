//
//  OSUnfairLockDemo.m
//  Multi-ThreadDemo
//
//  Created by Twisted Fate on 2022/4/1.
//

#import "OSUnfairLockDemo.h"
#import <os/lock.h>

@interface OSUnfairLockDemo ()

@property (nonatomic, assign) os_unfair_lock moneyLock;

@property (nonatomic, assign) os_unfair_lock ticketLock;

@end

@implementation OSUnfairLockDemo

- (void)test {
    
    // 初始化
    os_unfair_lock lock = OS_UNFAIR_LOCK_INIT;
    // 尝试加锁
    bool result = os_unfair_lock_trylock(&lock);
    // 加锁
    os_unfair_lock_lock(&lock);
    // 解锁
    os_unfair_lock_unlock(&lock);
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.moneyLock = OS_UNFAIR_LOCK_INIT;
        self.ticketLock = OS_UNFAIR_LOCK_INIT;
    }
    return self;
}


- (void)_saleTicket {
    os_unfair_lock_lock(&_ticketLock);
    [super _saleTicket];
    os_unfair_lock_unlock(&_ticketLock);
}

- (void)_saveMoney {
    os_unfair_lock_lock(&_moneyLock);
    [super _saveMoney];
    os_unfair_lock_unlock(&_moneyLock);

}

- (void)_drawMoney {
    os_unfair_lock_lock(&_moneyLock);
    [super _drawMoney];
    os_unfair_lock_unlock(&_moneyLock);

}
@end
