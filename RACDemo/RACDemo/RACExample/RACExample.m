//
//  RACExample.m
//  RACDemo
//
//  Created by Twisted Fate on 2022/7/21.
//

#import "RACExample.h"

@interface RACExample ()

@property (nonatomic, strong) RACCommand *command;

@end

@implementation RACExample

- (void)__RACSignal {
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        /// 被订阅的时候调用block
        NSLog(@"信号被订阅");
        /// 发送信号
        [subscriber sendNext:@1];
        /// 发送完成
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号被销毁");
        }];
    }];
    
    
    
    
    
    
    /// 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到信号:%@", x);
    }];
}

- (void)__RACSubject {
    
    RACSubject *subject = [RACSubject subject];
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一个订阅者:%@", x);
    }];
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第二个订阅者:%@", x);
    }];
    [subject sendNext:@1];
}


- (void)__RACReplaySubject {
    
    // 1.创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    // 2.发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    // 订阅信号
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一个订阅者接收到的数据%@",x);
    }];
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第二个订阅者接收到的数据%@",x);
    }];
}

- (void)__RACTuple_RACSequence {
    
    NSArray *numbers = @[@1, @2, @3, @4];
    [numbers.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    NSDictionary *dict = @{@"name": @"xmg", @"age":@18};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple   * _Nullable x) {
        RACTupleUnpack(NSString *key, NSString *value) = x;
        NSLog(@"key:%@, value:%@", key, value);
    }];
}

- (void)__RACCommand {
    
    self.command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"执行命令");
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"请求数据"];
            // 注意：数据传递完，最好调用sendCompleted，这时命令才执行完毕。
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    // 订阅command中的信号
    [self.command.executionSignals subscribeNext:^(id  _Nullable x) {
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@", x);
        }];
    }];
}

@end
