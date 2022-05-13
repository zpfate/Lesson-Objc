//
//  main.m
//  RuntimeDemo
//
//  Created by Twisted Fate on 2022/3/17.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "TF_Runtime.h"

#import "Person.h"


struct test {
    char tall: 1;
    char handsome:1;
    char rich:1;
};


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        
        NSLog(@"---------%lu", class_getInstanceSize(Person.class));
        
        
        Person *p = [[Person alloc] init];
//        p.rich = YES;
//        p.tall = YES;
//        p.handsome = YES;
        
        NSLog(@"rich:%d, tall:%d, handsome:%d", p.isRich, p.isTall, p.isHandsome);
    }
    return 0;
}
