//
//  main.m
//  RuntimeDemo
//
//  Created by Twisted Fate on 2022/3/17.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ZPOptionsNone = 0,
    ZPOptionsNew = 1 << 0,
    ZPOptionsOld = 1 << 1,
    ZPOptionsAll = 1 << 2,
} ZPOptions;


#import "Person.h"


- (void)setOptions:(ZPOptions)options {
    if (options & ZPOptionsNew) {
        
    }
    if (options & ZPOptionsOld) {
        
    }
    if (options & ZPOptionsAll) {
        
    }
 
}

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
