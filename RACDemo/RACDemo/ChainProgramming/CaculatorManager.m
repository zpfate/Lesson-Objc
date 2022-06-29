//
//  CaculatorManager.m
//  RACDemo
//
//  Created by Twisted Fate on 2022/6/10.
//

#import "CaculatorManager.h"

@interface CaculatorMaker ()

@property (nonatomic, assign) int result;

@end

@implementation CaculatorMaker

- (instancetype)init {
    if (self = [super init]) {
        _result = 0;
    }
    return self;
}

- (CaculatorBlock)add {
    return ^(int num) {
        self.result += num;
        return self;
    };
}

- (CaculatorBlock)minus {
    return ^(int num) {
        self.result -= num;
        return self;
    };
}

- (CaculatorBlock)multiply {
    return ^(int num) {
        self.result *= num;
        return self;
    };
}

- (CaculatorBlock)divide {
    return ^(int num) {
        self.result /= num;
        return self;
    };
}

- (void (^)(void))printResult {
    return ^{
        NSLog(@"result = %d", self.result);
    };
}


@end

