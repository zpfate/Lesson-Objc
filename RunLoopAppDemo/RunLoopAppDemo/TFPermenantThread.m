//
//  TFPermenantThread.m
//  RunLoopAppDemo
//
//  Created by Twisted Fate on 2022/3/31.
//

#import "TFPermenantThread.h"
@interface TFThread : NSThread

@end

@implementation TFThread

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}

@end

@interface TFPermenantThread ()

@property (nonatomic, strong) TFThread *innerThread;

@property (nonatomic, assign, getter=isStopped) BOOL stopped;

@end

@implementation TFPermenantThread

- (instancetype)init {
    self = [super init];
    if (self) {
        self.stopped = NO;
        
        __weak typeof(self) weakSelf = self;
        // 开启一个子线程
        self.innerThread = [[TFThread alloc] initWithBlock:^{
            
            NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
            NSPort *port = [[NSPort alloc] init];
            [runLoop addPort:port forMode:NSDefaultRunLoopMode];
            
            // C语言API

            // 创建上下文 清空初始化
//            CFRunLoopSourceContext context = {0};
//            // 创建Source
//            CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
//            // 添加Source
//            CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
//            // 销毁Source
//            CFRelease(source);
            
            if (weakSelf && !weakSelf.isStopped) {
                NSLog(@"******Permenant Thread Start******");
                // 获取当前线程的RunLoop
         
                [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
                
            
                // 启动
                // 第三个参数returnAfterSourceHandled
                // 设置为true 代表执行完Source就退出当前RunLoop
                // 设置为false 不需要循环
//                CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, true);
                
                NSLog(@"******Permenant Thread Stop******");
            }
        }];
    }
    return self;
}

- (void)dealloc {
    [self stop];
}

+ (instancetype)thread {
    TFPermenantThread *thread = [[TFPermenantThread alloc] init];
    return thread;
}

- (void)run {
    if (!self.innerThread) return;
    [self.innerThread start];
}


- (void)excuteTaskWithTarget:(id)target ation:(SEL)action object:(id)object {
    
    if (!self.innerThread) return;
    
    [target performSelector:action onThread:self.innerThread withObject:object waitUntilDone:NO];
}

- (void)excuteTask:(void (^)(void))task {
    
    [self performSelector:@selector(__excuteTask:) onThread:self.innerThread withObject:task waitUntilDone:NO];
}

- (void)stop {
    
    if (!self.innerThread) return;
    [self performSelector:@selector(__stopThread) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}

#pragma mark -- Private Methods

- (void)__excuteTask:(void (^)(void))task {
    task();
}

- (void)__stopThread {
    self.stopped = YES;
    // 停止RunLoop
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}

@end
