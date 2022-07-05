//
//  Present.m
//  MVCDemo
//
//  Created by Twisted Fate on 2022/7/5.
//

#import "Present.h"

@implementation Present

- (void)loadData:(void(^)(NSArray *arr))completion {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"json" ofType:@"plist"];
    NSArray *data = [NSArray arrayWithContentsOfFile:filePath];
    if (completion) {
        completion(data);
    }
}

@end
