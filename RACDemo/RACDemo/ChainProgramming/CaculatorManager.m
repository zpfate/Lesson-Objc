//
//  CaculatorManager.m
//  RACDemo
//
//  Created by Twisted Fate on 2022/6/10.
//

#import "CaculatorManager.h"

@interface CaculatorMaker ()

@property (nonatomic, strong) int result;

@end

@implementation CaculatorMaker

- (CaculatorBlock)add {
    return ^ (int num){
        
        return self;
    };
}

@end

