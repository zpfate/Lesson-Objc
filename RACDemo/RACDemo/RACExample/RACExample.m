//
//  RACExample.m
//  RACDemo
//
//  Created by Twisted Fate on 2022/7/21.
//

#import "RACExample.h"

@implementation RACExample

- (void)__RACSignal {
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
       
        /// 被订阅的时候调用block
        
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
            
    }];
}





@end
