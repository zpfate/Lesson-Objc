//
//  TFProxy.h
//  TimerDemo
//
//  Created by Twisted Fate on 2022/4/7.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface TFProxy : NSProxy
@property (nonatomic, weak) id target;

+ (instancetype)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
