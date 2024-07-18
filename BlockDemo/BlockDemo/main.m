//
//  main.m
//  BlockDemo
//
//  Created by Twisted Fate on 2021/3/15.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        
        NSLog(@"1----%@, %@", [NSObject alloc], [NSObject new]);
        
        Person *p = [[Person alloc] init];
        [p blockDemo];
        
        
        
        
        p.age = 20;
//        p.block = ^{
//            NSLog(@"age is %zd", p.age);
//            p = nil;
//        };
        p.block();
        
        
        void(^globalBlock)(void) = ^() {
            NSLog(@"globalBlock");
        };
        /// __NSGlobalBlock__
        NSLog(@"globalBlock === %@", [globalBlock class]);
        NSInteger num = 3;
        void(^mallocBlock)(void) = ^() {
            NSLog(@"sum=%zd", num);
        };
    
        /// __NSMallocBlock__
        NSLog(@"mallocBlock=%@", [mallocBlock class]);

        NSLog(@"=%@", [^(){
            NSLog(@"stackBlock=%zd", num);

        } class]);
        
        
        
    }
    return 0;
}
