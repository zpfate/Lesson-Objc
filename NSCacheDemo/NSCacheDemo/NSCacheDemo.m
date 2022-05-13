//
//  NSCacheDemo.m
//  NSCacheDemo
//
//  Created by Twisted Fate on 2022/4/20.
//

#import "NSCacheDemo.h"

@interface NSCacheDemo ()<NSCacheDelegate>

@end

@implementation NSCacheDemo

- (void)cacheTest {
    
    NSCache *cache = [[NSCache alloc] init];
    cache.countLimit = 5;
    cache.delegate = self;
    for (int i = 0; i < 7; i++) {
        [cache setObject:[NSString stringWithFormat:@"object-%d", i] forKey:[NSString stringWithFormat:@"key-%d", i]];
    }
    
    NSLog(@"-------------");
}

- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    NSLog(@"obj = %@", obj);
}

@end
