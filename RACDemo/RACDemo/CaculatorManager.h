//
//  CaculatorManager.h
//  RACDemo
//
//  Created by Twisted Fate on 2022/6/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CaculatorManager;
@interface CaculatorManager : NSObject

- (CaculatorManager *(^)(int value))add;

@end


@interface CaculatorMaker : NSObject

+ (int)makeCaculator:(void(^)(CaculatorManager *make))block;

@end



NS_ASSUME_NONNULL_END
