//
//  ViewController.m
//  TaggedPointerDemo
//
//  Created by Twisted Fate on 2022/4/11.
//

#import "ViewController.h"
#import "Person.h"
@interface ViewController ()
@property (nonatomic, copy) NSString *name;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    __strong Person *p1;

    __weak Person *p2;
    __unsafe_unretained Person *p3;
    
    NSLog(@"123");
    {
        Person *p = [[Person alloc] init];
        p3 = p;
    }
    
    NSLog(@"123 - %@", p3);

}

- (void)test1 {
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 1000; i++) {
        /// 多条线程访问_name release
        dispatch_async (queue, ^{
            self.name = [NSString stringWithFormat:@"abcdefghijlk"];
        });
    }
}

- (void)test2 {
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 1000; i++) {
        /// 多条线程访问_name release
        dispatch_async(queue, ^{
            self.name = [NSString stringWithFormat:@"abc"];
        });
    }
}

@end
