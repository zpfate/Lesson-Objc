//
//  ViewController.m
//  KVODemo
//
//  Created by Twisted Fate on 2022/3/14.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
@interface ViewController ()
@property (nonatomic, strong) Person *p;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.p = [[Person alloc] init];
    self.p.age = 20;
    
        NSLog(@"KVO添加之前-%@", object_getClass(self.p));

    
//    NSLog(@"KVO添加之前-%@", object_getClass(self.p));
    [self.p addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
//    NSLog(@"KVO添加之后-%@", object_getClass(self.p));

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == nil) {
        NSLog(@"%@的%@改变了", object, keyPath);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.p.age = 21;
}

@end
