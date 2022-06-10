//
//  ViewController.m
//  RACDemo
//
//  Created by Twisted Fate on 2022/6/9.
//

#import "ViewController.h"
#import "ViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (nonatomic, strong) ViewModel *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /// 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        /// 每当有订阅者订阅信号的时候,就会调用block
        
        /// 发送信号
        [subscriber sendNext:@1];
        
        /// 如果不在发送数据,最好设置发送信号完成,内部会自动调用[RACDisposable disposable]取消订阅信号
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            /// 信号发送完成或者发送错误,会执行block
            
            /// 执行完成block之后, 当前信号就不在订阅了
            NSLog(@"信号被销毁");
        }];
        
    }];
    
    /// 订阅信号,才会激活信号
    [signal subscribeNext:^(id x) {
       
        /// 每当有信号发出数据,就会调用
        NSLog(@"接收到数据:%@", x);
    }];
    
    
}



- (ViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ViewModel alloc] init];
    }
    return _viewModel;
}


@end
