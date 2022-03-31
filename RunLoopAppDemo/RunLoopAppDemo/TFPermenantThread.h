//
//  TFPermenantThread.h
//  RunLoopAppDemo
//
//  Created by Twisted Fate on 2022/3/31.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFPermenantThread : NSObject

/**
 * 开启线程
 */
- (void)run;

- (void)excuteTaskWithTarget:(id)target ation:(SEL)action object:(id)object;

- (void)excuteTask:(void(^)(void))block;

- (void)stop;

@end

NS_ASSUME_NONNULL_END
