//
//  TFTimer.h
//  TimerDemo
//
//  Created by Twisted Fate on 2022/4/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TFTimer : NSObject

+ (NSTimer *)tf_timerWithRuningTime:(NSTimeInterval)runingTime
    interval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(TFTimer *timer))block;

@end

NS_ASSUME_NONNULL_END
