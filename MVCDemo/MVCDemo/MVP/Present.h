//
//  Present.h
//  MVCDemo
//
//  Created by Twisted Fate on 2022/7/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MVPModel;

@interface Present : NSObject

- (void)loadData:(void(^)(NSArray *arr))completion;

- (NSInteger)count;

- (MVPModel *)modelAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
