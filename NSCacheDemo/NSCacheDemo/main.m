//
//  main.m
//  NSCacheDemo
//
//  Created by Twisted Fate on 2022/4/20.
//

#import <Foundation/Foundation.h>
#import "NSCacheDemo.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");

        NSString *key = @"key";
        
        NSCacheDemo *demo = [NSCacheDemo new];
        NSLog(@"--- %zd", demo.retainCount);
        NSDictionary *dict = @{@"key":demo};
        NSLog(@"--- %zd", demo.retainCount);

        NSOperation
        
        
//        NSCacheDemo *demo = [NSCacheDemo new];
//        [demo cacheTest];
        
        
        
    }
    return 0;
}
