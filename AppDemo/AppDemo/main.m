//
//  main.m
//  AppDemo
//
//  Created by Twisted Fate on 2022/3/28.
//

#import <Cocoa/Cocoa.h>

/*
 局部变量分布在栈空间
 栈空间分配,从高地址到低地址
 */
void test() {
    
    long long a = 4; // 0x7ff7bbbbe2d8
    long long b = 5; // 0x7ff7bbbbe2d0
    long long c = 6; // 0x7ff7bbbbe2c8

    NSLog(@"%p %p %p", &a, &b, &c);
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
    }
    
    test();
    return NSApplicationMain(argc, argv);
}
