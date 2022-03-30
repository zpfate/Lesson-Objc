//
//  ViewController.m
//  RunLoopAppDemo
//
//  Created by Twisted Fate on 2022/3/30.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    static int count = 0;
    // 滑动时 定时器不工作
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"%d", count++);
    }];
    
    //
}


@end
