//
//  TFURLProtocol.m
//  NSURLProtocolDemo
//
//  Created by Twisted Fate on 2021/4/8.
//

#import "TFCustomerURLProtocol.h"


static NSString *TFCusomterProtocolKey = @"TFCusomterProtocolKey";

@implementation TFCustomerURLProtocol

/// 向NSURLProtocol注册
+ (void)start {
    
    [NSURLProtocol registerClass:self];
}

/// 是否接受处理这个请求 返回NO则由URL Loading System使用系统默认的行为处理
/// @param request 请求
+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    
    BOOL shouldAccept;
    NSURL *url = request.URL;
    shouldAccept = (request != nil) && (url != nil);
    
    if (shouldAccept) {
        /// 防止递归调用
//        shouldAccept = ![NSURLProtocol propertyForKey:TFCusomterProtocolKey inRequest:request];
    }
    
    if (shouldAccept) {
        
        NSString *scheme = url.scheme;
        shouldAccept = [scheme isEqualToString:@"http"];
    }
    return shouldAccept;
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
    
    NSMutableURLRequest *recursiveRequest = [[self request] mutableCopy];
//    [[self class] setProperty:@YES forKey:TFCusomterProtocolKey inRequest:recursiveRequest];
}

/// 停止相应请求
- (void)stopLoading {
    
}


@end
