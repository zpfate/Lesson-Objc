//
//  NSConditionLockDemo.m
//  Multi-ThreadDemo
//
//  Created by Twisted Fate on 2022/4/6.
//

#import "NSConditionLockDemo.h"

@interface NSConditionLockDemo()

@property (nonatomic, strong) NSConditionLock *conditionLock;
@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation NSConditionLockDemo

- (void)test {
    // 初始化
    NSConditionLock *conditionLock = [[NSConditionLock alloc] initWithCondition:1];
    // 加锁
    [conditionLock lock];
    // 符合条件加锁
    [conditionLock lockWhenCondition:1];
    // 解锁
    [conditionLock unlock];
    // 符合条件解锁
    [conditionLock unlockWithCondition:1];
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _conditionLock = [[NSConditionLock alloc] initWithCondition:1];
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
    [self.conditionLock lockWhenCondition:1];
    if (self.data.count == 0) {
        // 进入休眠 等待条件的唤醒 会放开锁,条件满足再被唤醒再次加锁
//        [self.conditionLock wait];
    }
    [self.data removeLastObject];
    NSLog(@"进行删除元素操作");
    [self.conditionLock unlockWithCondition:2];
    
}

- (void)__add {
    
    // 等到条件符合的时候
    [self.conditionLock lockWhenCondition:2];
    [self.data addObject:@"test"];
    NSLog(@"进行添加元素操作");
    
    [self.conditionLock unlock];

}

@end
