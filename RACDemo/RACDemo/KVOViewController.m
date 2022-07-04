//
//  KVOViewController.m
//  RACDemo
//
//  Created by Twisted Fate on 2022/7/4.
//

#import "KVOViewController.h"

@interface KVOViewController ()

@property (weak, nonatomic) IBOutlet UIView *kvoView;

@property (weak, nonatomic) IBOutlet UITextField *racTF;


@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // KVO
    [[self.kvoView rac_valuesForKeyPath:@"frame" observer:self] subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到改变:%@", x);
    }];
    
    
    // 通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"接收到通知:%@", x);
    }];
    
    // 文本框
    [self.racTF.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"接收到TextField内容改变:%@", x);
    }];
    
    
    [[RACSignal interval:1 onScheduler:[RACScheduler scheduler]] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"Timer:%@",x);
    }];
    
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.kvoView.frame = CGRectMake(100, 200, 100, 100);
}

@end
