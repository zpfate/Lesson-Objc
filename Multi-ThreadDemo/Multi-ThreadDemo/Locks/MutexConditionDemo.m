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

// 生产者 - 消费者模式
// 生产者得先生产出商品 消费者才能进行购买
// 条件锁测试
// 满足数组有元素才执行删除元素的操作
- (void)conditionTest {
    
    [[[NSThread alloc] initWithTarget:self selector:@selector(__remove) object:nil] start];
    [[[NSThread alloc] initWithTarget:self selector:@selector(__add) object:nil] start];
}

- (void)__remove {
    pthread_mutex_lock(&_mutex);
    if (self.data.count == 0) {
        // 进入休眠 等待条件的唤醒 会放开锁,条件满足再被唤醒再次加锁
        pthread_cond_wait(&_condt, &_mutex);
    }
    [self.data removeLastObject];
    NSLog(@"进行删除元素操作");
    pthread_mutex_unlock(&_mutex);
    
}

- (void)__add {
    
    pthread_mutex_lock(&_mutex);
    [self.data addObject:@"test"];
    NSLog(@"进行添加元素操作");

    // 唤醒条件 信号:就是唤醒一个等待该条件的线程
    pthread_cond_signal(&_condt);
    
    
    // 广播 激活所有等待该条件的线程
    pthread_cond_broadcast(&_condt);
    
    pthread_mutex_unlock(&_mutex);
}


- (void)dealloc {
    
    pthread_mutex_destroy(&_mutex);
    pthread_cond_destroy(&_condt);

}

@end
