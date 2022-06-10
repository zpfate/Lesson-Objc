//
//  CaculatorManager.m
//  RACDemo
//
//  Created by Twisted Fate on 2022/6/10.
//

#import "CaculatorManager.h"

@interface CaculatorManager ()

@property (nonatomic, assign) int result;

@end

@implementation CaculatorManager

- (CaculatorManager *(^)(int))add {
    
    __weak __typeof(self) weaksSelf = self;
    return ^(int num) {
        weaksSelf.result += num;
        return weaksSelf;
    };
    
}

@end


@interface CaculatorMaker ()

@end

@class CaculatorManager;
@implementation CaculatorMaker

+ (int)makeCaculator:(void(^)(CaculatorManager *make))block {
    
    CaculatorManager *manager = [[CaculatorManager alloc] init];
    block(manager);
    return manager.result;
}

@end



