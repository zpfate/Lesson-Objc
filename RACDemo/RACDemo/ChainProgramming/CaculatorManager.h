//
//  CaculatorManager.h
//  RACDemo
//
//  Created by Twisted Fate on 2022/6/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CaculatorMaker;

typedef CaculatorMaker *_Nonnull(^CaculatorBlock)(int num);

@interface CaculatorMaker : NSObject


@property (nonatomic, readonly) CaculatorBlock add;

@property (nonatomic, readonly) CaculatorBlock minus;

@property (nonatomic, readonly) CaculatorBlock multiply;

@property (nonatomic, readonly) CaculatorBlock divide;


@end





NS_ASSUME_NONNULL_END
