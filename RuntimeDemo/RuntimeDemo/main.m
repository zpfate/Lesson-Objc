//
//  main.m
//  RuntimeDemo
//
//  Created by Twisted Fate on 2022/3/17.
//

#import <Foundation/Foundation.h>



#import "Person.h"



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        Person *p = [[Person alloc] init];
//        p.rich = YES;
//        p.tall = YES;
//        p.handsome = YES;
        
        NSLog(@"rich:%d, tall:%d, handsome:%d", p.isRich, p.isTall, p.isHandsome);
    }
    return 0;
}
