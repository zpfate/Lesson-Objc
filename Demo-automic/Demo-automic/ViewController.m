//
//  ViewController.m
//  Demo-automic
//
//  Created by Twisted Fate on 2022/4/6.
//

#import "ViewController.h"
#import <pthread.h>
@interface ViewController ()

@property (nonatomic, assign) pthread_rwlock_t lock;

@property (nonatomic, strong) dispatch_queue_t queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    pthread_rwlock_init(&_lock, NULL);
//    self.queue = dispatch_queue_create("rw", DISPATCH_QUEUE_CONCURRENT);
//    for (int i = 0; i < 10; i++) {
//        [self barrierRead];
//        [self barrierWrite];
//    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            [self read];
            [self read];
        });
        dispatch_async(queue, ^{
            [self write];
        });
    }
}


- (void)barrier {
    
    dispatch_queue_t queue = dispatch_queue_create("rw", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
       // 读
        [self barrierRead];
    });
    dispatch_barrier_async(queue, ^{
        [self barrierWrite];
    });
    
}

- (void)barrierRead {
    
    dispatch_async(self.queue, ^{
        sleep(1);
        NSLog(@"read");
    });
}

- (void)barrierWrite {
    
    dispatch_barrier_async(self.queue, ^{
        sleep(1);
        NSLog(@"write");
    });
}


- (void)read {
    
    pthread_rwlock_rdlock(&_lock);
    sleep(1);
    NSLog(@"%s", __func__);
    pthread_rwlock_unlock(&_lock);
}

- (void)write {
    // 加锁
    pthread_rwlock_wrlock(&_lock);
    sleep(1);
    NSLog(@"%s", __func__);
    // 解锁
    pthread_rwlock_unlock(&_lock);

}



@end
