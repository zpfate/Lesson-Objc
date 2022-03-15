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
        
        
        Person *p = [[Person alloc] init];
        [p call];
        [Person call];
        [Person isKindOfClass:[Person class]];
        
        
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
