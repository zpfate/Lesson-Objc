//
//  NSConditionDemo.m
//  Multi-ThreadDemo
//
//  Created by Twisted Fate on 2022/4/6.
//

#import "NSConditionDemo.h"

@interface NSConditionDemo()

@property (nonatomic, strong) NSCondition *condition;
@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation NSConditionDemo


- (instancetype)init
{
    self = [super init];
    if (self) {
        _condition = [[NSCondition alloc] init];
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
    [self.condition lock];
    if (self.data.count == 0) {
        // 进入休眠 等待条件的唤醒 会放开锁,条件满足再被唤醒再次加锁
//        [self.conditionLock wait];
    }
    [self.data removeLastObject];
    NSLog(@"进行删除元素操作");
    [self.condition unlock];
    
}

- (void)__add {
    
    [self.condition lock];
    [self.data addObject:@"test"];
    NSLog(@"进行添加元素操作");
    [self.condition signal];
    [self.condition broadcast];
    [self.condition unlock];

}

@end
