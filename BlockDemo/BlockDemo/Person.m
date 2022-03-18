//
//  Person.m
//  BlockDemo
//
//  Created by Twisted Fate on 2022/2/16.
//

#import "Person.h"

@implementation Person

- (NSString *)description {
    return [NSString stringWithFormat:@"name = %@, age = %zd", self.name, self.age];
}

- (void)call {
    __weak typeof(self) weakSelf = self;
    self.block = ^{
        NSLog(@"age is %zd", weakSelf->_age);

    };
}

+ (void)call {
 
}

- (void)dealloc
{
    NSLog(@"Person dealloc");
}

@end
