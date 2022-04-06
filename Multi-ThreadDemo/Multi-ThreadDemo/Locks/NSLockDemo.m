//
//  NSLockDemo.m
//  Multi-ThreadDemo
//
//  Created by Twisted Fate on 2022/4/6.
//

#import "NSLockDemo.h"

@interface NSLockDemo ()

@property (nonatomic, strong) NSLock *moneyLock;

@property (nonatomic, strong) NSLock *ticketLock;


@end

@implementation NSLockDemo

// test API
- (void)test {
    

    // 初始化
    NSLock *lock = [[NSLock alloc] init];
    // 尝试加锁
    [lock tryLock];
    // 加锁
    [lock lock];
    // 解锁
    [lock unlock];
    // 在传入时间到来前加锁,时间没到就休眠,时间到了加锁,
    // 加锁成功就返回YES,加锁失败或超出时间就返回NO
//    lock lockBeforeDate:<#(nonnull NSDate *)#>

}



- (instancetype)init
{
    self = [super init];
    if (self) {
        _moneyLock = [[NSLock alloc] init];
        _ticketLock = [[NSLock alloc] init];

    }
    return self;
}


- (void)_saleTicket {
    [_ticketLock lock];
    [super _saleTicket];
    [_ticketLock unlock];
}

- (void)_saveMoney {
    [_moneyLock lock];
    [super _saveMoney];
    [_moneyLock unlock];
}

- (void)_drawMoney {
    [_moneyLock lock];
    [super _drawMoney];
    [_moneyLock unlock];

}

- (void)dealloc {
    

}

@end
