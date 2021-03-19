//
//  main.m
//  BlockDemo
//
//  Created by Twisted Fate on 2021/3/15.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        NSInteger num = 3;
        NSInteger(^sumBlock)(NSInteger) = ^NSInteger(NSInteger n) {
            
            return num + n;
        };
        sumBlock(3);
    }
    return 0;
}
