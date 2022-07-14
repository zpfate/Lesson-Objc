//
//  LoginViewModel.m
//  RACDemo
//
//  Created by Twisted Fate on 2022/6/13.
//

#import "LoginViewModel.h"

@interface LoginViewModel ()

@property (nonatomic, strong) RACCommand *command;

@end

@implementation LoginViewModel

- (instancetype)init {
    if (self = [super init]) {
              
        [self setupSignal];
        
    }
    return self;
}


- (void)setupSignal {
    
    RACSignal *phoneSignal = [RACObserve(self, account) filter:^BOOL(NSString * _Nullable value) {
        return value.length == 11;
    }];
    
    RACSignal *pwdSignal = [RACObserve(self, pwd) filter:^BOOL(NSString *  _Nullable value) {
        return value.length >= 8;
    }];
    
    /// 组合信号
    [[RACSignal combineLatest:@[phoneSignal, pwdSignal]] subscribeNext:^(RACTuple * _Nullable x) {
        
        [self.loginCommand execute:nil];
    }];
    
    
    [[self.loginCommand.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
            
    }];
    
    [self.loginCommand.errors subscribeNext:^(NSError * _Nullable x) {
            
        NSLog(@"登录失败的处理逻辑");
        //
        
    }];
    
    // 状态
   [[self.loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
       NSLog(@"请求 executing = %@",x);
       
       if ([x boolValue]) {
           
       } else {
           
       }
   }];

    
}

- (void)login {
    
    [self.loginCommand execute:@"登录"];
}

- (RACCommand *)loginCommand {
    
    if (!_loginCommand) {
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                NSLog(@"请求登录接口-----");
                NSLog(@"account:%@, pwd:%@", self.account, self.pwd);
                
                if ([self.account isEqualToString:@"123"] && [self.pwd isEqualToString:@"123456"]) {
                    
                    /// 模拟登录成功~
                    [subscriber sendNext:@(YES)];
                    [subscriber sendCompleted];
                    
                } else {
                    
                    NSError *err = [NSError errorWithDomain:NSURLErrorDomain code:400 userInfo:@{@"message": @"用户名或者密码错误"}];
                    [subscriber sendError:err];
                }
                
                return nil;
            }];
        }];
    }
    return _loginCommand;
}

@end
