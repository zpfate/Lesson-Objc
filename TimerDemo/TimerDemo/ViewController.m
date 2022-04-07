//
//  ViewController.m
//  TimerDemo
//
//  Created by Twisted Fate on 2022/4/7.
//

#import "ViewController.h"
#import "TFProxy.h"
@interface ViewController ()

@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) dispatch_source_t gcdTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 无法解决, 用于block解决循环引用
    __weak typeof(self) weakSelf = self;
    
    
    
    [self initGCDTimer];
    

}

- (void)initGCDTimer {
    // 队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    // 创建GCD定时器
    self.gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置时间
    NSTimeInterval start = 2.0; // 2s后开始执行
    NSTimeInterval interval = 1.0; // 每隔1s执行
    
    NSLog(@"begin");
    
    // 纳秒
    dispatch_source_set_timer(self.gcdTimer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
    
    // 设置回调
    dispatch_source_set_event_handler(self.gcdTimer, ^{
        NSLog(@"-----");
    });
    dispatch_resume(self.gcdTimer);
}

- (void)initTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:[TFProxy proxyWithTarget:self] selector:@selector(timerTest) userInfo:nil repeats:YES];
    
  
}

- (void)initLink {
    // 保证调用频率和屏幕的刷帧频率一致 60fps
    self.link = [CADisplayLink displayLinkWithTarget:[TFProxy proxyWithTarget:self] selector:@selector(linkTest)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)linkTest {
    NSLog(@"%s", __func__);
}

- (void)timerTest {
    NSLog(@"%s", __func__);
}

@end
