//
//  OSSpinLockDemo.m
//  Multi-ThreadDemo
//
//  Created by Twisted Fate on 2022/4/1.
//

#import "OSSpinLockDemo.h"
#import <libkern/OSAtomic.h>

@interface OSSpinLockDemo ()
@property (nonatomic, assign) OSSpinLock moneyLock;

@end

@implementation OSSpinLockDemo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.moneyLock = OS_SPINLOCK_INIT;

    }
    return self;
}

- (void)_saleTicket {
    
    static OSSpinLock _ticketLock = OS_SPINLOCK_INIT;
    OSSpinLockLock(&_ticketLock);
    [super _saleTicket];
    OSSpinLockUnlock(&_ticketLock);
}

- (void)_saveMoney {
    OSSpinLockLock(&_moneyLock);
    [super _saveMoney];
    OSSpinLockUnlock(&_moneyLock);
}

- (void)_drawMoney {
    OSSpinLockLock(&_moneyLock);
    [super _drawMoney];
    OSSpinLockUnlock(&_moneyLock);
}

@end
