//
//  ViewController.m
//  Lesson_ReactiveObjc
//
//  Created by Twisted Fate on 2022/7/22.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self __test];
}

- (void)__test {
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
       
        [subscriber sendNext:@1];
        
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
          
            NSLog(@"释放");
        }];
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
            
    }];
    
    
    RACSubject *subject = [RACSubject subject];
    [subject subscribeNext:^(id  _Nullable x) {
            
    }];
    [subject sendNext:@1];
    
}

@end
