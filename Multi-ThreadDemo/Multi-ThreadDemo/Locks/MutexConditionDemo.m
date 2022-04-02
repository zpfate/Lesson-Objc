//
//  MutexConditionDemo.m
//  Multi-ThreadDemo
//
//  Created by Twisted Fate on 2022/4/2.
//

#import "MutexConditionDemo.h"
#import <pthread.h>

@interface MutexConditionDemo ()

@property (nonatomic, assign) pthread_mutex_t mutex;
@property (nonatomic, assign) pthread_cond_t condt;
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation MutexConditionDemo

- (void)__initLock:(pthread_mutex_t *)mutex {
    
    pthread_mutexattr_t attr;
    pthread_mutexattr_init(&attr);
    // 锁的类型
    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_DEFAULT);
    // 初始化锁
    pthread_mutex_init(mutex, &attr);
    // 销毁属性
    pthread_mutexattr_destroy(&attr);
    // 初始化条件
    pthread_cond_init(&_condt, NULL);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self __initLock:&_mutex];
    }
    return self;
}


- (void)__remove {
    pthread_mutex_lock(&_mutex);
    if (self.data.count == 0) {
        // 等待 会放开锁,条件满足再通知被唤醒继续加锁
        pthread_cond_wait(&_condt, &_mutex);
    }
    [self.data removeLastObject];
    pthread_mutex_unlock(&_mutex);
    
}

- (void)__add {
    
    pthread_mutex_lock(&_mutex);
    [self.data addObject:@"test"];
    
    // 唤醒
    pthread_cond_signal(&_condt);
    
    pthread_mutex_unlock(&_mutex);
}


- (void)dealloc {
    pthread_mutex_destroy(&_mutex);
    pthread_cond_destroy(&_condt);

}

@end
