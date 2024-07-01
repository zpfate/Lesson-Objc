//
//  ViewController.m
//  AppDemo
//
//  Created by Twisted Fate on 2022/3/28.
//

#import "ViewController.h"
#import "Person.h"
@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     1. print为什么能调用成功
     2. 为什么self.name变成了ViewController
     */
    

    // 正常Person实例对象 person->isa-> Person Class
    
    // 本题: obj->isa-> Person Class

    id cls = [Person class];
    
    void *obj = &cls;
    
    [(__bridge id)obj print];
    
    
    
    
    

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
