//
//  ViewController.m
//  RunLoopAppDemo
//
//  Created by Twisted Fate on 2022/3/30.
//

#import "ViewController.h"
#import "TFThread.h"
#import "TFPermenantThread.h"
@interface ViewController ()

@property (nonatomic, strong) TFThread *thread;
@property (nonatomic, assign, getter=isStopped) BOOL stop;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
   
//    self.thread = [[TFThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    self.stop = NO;
    __weak typeof(self) weakSelf = self;
    self.thread = [[TFThread alloc] initWithBlock:^{
        NSLog(@"begin---%s %@", __func__, [TFThread currentThread]);
        
        // 往RunLoop里面添加Source\Timer\Observer
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        
        // NSRunLoop的run方法是无法停止的,它专门用于开启一个用不销毁的线程
        while (weakSelf && !weakSelf.stop) {
            NSLog(@"---%@", weakSelf);
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
//        [[NSRunLoop currentRunLoop] run];
        
        NSLog(@"end-----%@", [TFThread currentThread]);
    }];
    
    [self.thread start];

}

- (void)dealloc {
    // 停止RunLoop
    // waitUntilDone:等不等子线程完成再继续执行
    [self stopAction];
    self.thread = nil;
    NSLog(@"%s", __func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    // 在子线程执行test任务
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}

// 子线程需要执行的任务
- (void)test {
    NSLog(@"%s %@", __func__, [TFThread currentThread]);
}

- (IBAction)stopAction {
    if (!self.thread) return;
    [self performSelector:@selector(stopThread) onThread:self.thread withObject:nil waitUntilDone:YES];
}

// 停止子线程的RunLoop
- (void)stopThread {
    // 只能停止一次 用标志控制
    self.stop = YES;
    // 停止RunLoop
    CFRunLoopStop(CFRunLoopGetCurrent());
    
    NSLog(@"%s %@", __func__, [TFThread currentThread]);
    self.thread = nil;
}


- (void)run {
    NSLog(@"%s %@", __func__, [TFThread currentThread]);
    
    // 往RunLoop里面添加Source\Timer\Observer
    [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    
    NSLog(@"end-----%@", [TFThread currentThread]);

}



- (void)addTimer {
    static int count = 0;
    // 滑动时 定时器不工作
    // scheduledTimerWithTimeInterval默认加入RunLoop默认模式下
//     [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"%d", count++);
//    }];
    
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"%d", count++);
    }];
    
    // NSRunLoopCommonModes并不是一个真的模式 只是一个标记
    // NSDefaultRunLoopMode UITrackingRunLoopMode才是真正的模式
    // timer能在_commonModes数组存放的模式下工作
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

@end
