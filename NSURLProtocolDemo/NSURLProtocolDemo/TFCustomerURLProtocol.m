//
//  TFURLProtocol.m
//  NSURLProtocolDemo
//
//  Created by Twisted Fate on 2021/4/8.
//

#import "TFCustomerURLProtocol.h"


@interface TFCustomerURLProtocol ()<NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSession *session;

@end

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
        shouldAccept = ![self propertyForKey:TFCusomterProtocolKey inRequest:request];
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
    
    /// 如果是http请求改成https
    if ([request.URL.scheme isEqualToString:@"http"]) {
        NSMutableURLRequest *mutableRequest = [request mutableCopy];
        NSString *urlString = mutableRequest.URL.absoluteString;
        urlString = [urlString stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
        mutableRequest.URL = [NSURL URLWithString:urlString];
        return mutableRequest;
    }
    return request;
}

/// 此方法抽象类提供了默认实现,重写可以直接调用父类
/// 一般不做特殊处理, 直接返回父类实现
+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b {
    
    BOOL result = [super requestIsCacheEquivalent:a toRequest:b];
    return result;
}

/// 开始网络请求
- (void)startLoading {
    
    NSMutableURLRequest *recursiveRequest = [[self request] mutableCopy];
    [[self class] setProperty:@YES forKey:TFCusomterProtocolKey inRequest:recursiveRequest];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSMutableArray *protocolClasses = [configuration.protocolClasses mutableCopy];
    [protocolClasses addObject:self];
    configuration.protocolClasses = @[self.class];
    
    self.session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:recursiveRequest];
    [task resume];
}

/// 停止相应请求
- (void)stopLoading {
    
    [self.session invalidateAndCancel];
    self.session = nil;
}


#pragma mark -- NSURLSessionDataDelegate

/// 接收到服务响应时调用的方法
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    
    completionHandler(NSURLSessionResponseAllow);
}

///接收到服务器返回数据的时候会调用该方法，如果数据较大那么该方法可能会调用多次
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [[self client] URLProtocol:self didLoadData:data];
}

/// 当请求完成(成功|失败)的时候会调用该方法，如果请求失败，则error有值
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    
    if (error) {
        [[self client] URLProtocol:self didFailWithError:error];
    } else {
        [[self client] URLProtocolDidFinishLoading:self];

    }
}


@end
