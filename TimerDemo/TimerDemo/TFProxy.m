//
//  TFProxy.m
//  TimerDemo
//
//  Created by Twisted Fate on 2022/4/7.
//

#import "TFProxy.h"

@implementation TFProxy

+ (instancetype)proxyWithTarget:(id)target {
    TFProxy *proxy = [TFProxy alloc];
    proxy.target = target;
    return proxy;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.target;
}

@end
