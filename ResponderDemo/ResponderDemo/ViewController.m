//
//  ViewController.m
//  ResponderDemo
//
//  Created by Twisted Fate on 2021/3/22.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touches count == %lu\n touches == %@" , (unsigned long)touches.count, touches);
}


@end
