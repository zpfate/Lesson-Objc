//
//  TFURLProtocol.m
//  NSURLProtocolDemo
//
//  Created by Twisted Fate on 2021/4/8.
//

#import "TFURLProtocol.h"

@implementation TFURLProtocol

/// 子类能否响应请求, 可以在该方法中过滤
/// @param task 请求任务
+ (BOOL)canInitWithTask:(NSURLSessionTask *)task {
    
    return YES;
}

/// 自定义网络请求, 对请求进行修改，如URL重定向、添加Header
/// 无需额外处理可直接返回request
/// @param request 请求
+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    
    return request;
}


/// 此方法抽象类提供了默认实现,重写可以直接调用父类
/// @param a <#a description#>
/// @param b <#b description#>
+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b {
    return [super requestIsCacheEquivalent:a toRequest:b];
}

/// 开始网络请求
- (void)startLoading {
    
}

/// 停止相应请求
- (void)stopLoading {
    
}


@end
