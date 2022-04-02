//
//  PthreadMutexDemo.m
//  Multi-ThreadDemo
//
//  Created by Twisted Fate on 2022/4/2.
//

#import "PthreadMutexDemo.h"
#import <pthread.h>
@interface PthreadMutexDemo ()

@property (nonatomic, assign) pthread_mutex_t money_mutex;
@property (nonatomic, assign) pthread_mutex_t ticket_mutex;

@end

@implementation PthreadMutexDemo
// test API
- (void)test {
    
    // 静态初始化
//        pthread_mutex_t _mutex = PTHREAD_MUTEX_INITIALIZER;
    /**
     #define PTHREAD_MUTEX_NORMAL        0
     #define PTHREAD_MUTEX_ERRORCHECK    1
     #define PTHREAD_MUTEX_RECURSIVE        2  递归锁
     #define PTHREAD_MUTEX_DEFAULT        PTHREAD_MUTEX_NORMAL 普通的锁
     */
    
    // 初始化锁的属性
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    // 锁的类型
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
    // 初始化锁
    pthread_mutex_t _mutex;
    pthread_mutex_init(&_mutex, &attr);
    // 销毁属性
    pthread_mutexattr_destroy(&attr);
    
    // 加锁
    pthread_mutex_lock(&_mutex);
    // 解锁
    pthread_mutex_unlock(&_mutex);
    // 销毁
    pthread_mutex_destroy(&_mutex);

}

- (void)__initLock:(pthread_mutex_t *)mutex {
    
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    // 锁的类型
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
    // 初始化锁
    pthread_mutex_init(mutex, &attr);
    // 销毁属性
    pthread_mutexattr_destroy(&attr);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self __initLock:&_ticket_mutex];
        [self __initLock:&_money_mutex];
    }
    return self;
}


- (void)_saleTicket {
    pthread_mutex_lock(&_ticket_mutex);
    [super _saleTicket];
    pthread_mutex_unlock(&_ticket_mutex);
}

- (void)_saveMoney {
    pthread_mutex_lock(&_money_mutex);
    [super _saveMoney];
    pthread_mutex_unlock(&_money_mutex);
}

- (void)_drawMoney {
    pthread_mutex_lock(&_money_mutex);
    [super _drawMoney];
    pthread_mutex_unlock(&_money_mutex);

}

- (void)dealloc {
    pthread_mutex_destroy(&_ticket_mutex);
    pthread_mutex_destroy(&_money_mutex);

}

@end

