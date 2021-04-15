//
//  ViewController.m
//  NSURLProtocolDemo
//
//  Created by Twisted Fate on 2021/4/8.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
@interface ViewController ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
//    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
//    webView.navigationDelegate = self;
//    [self.view addSubview:webView];

    [self requestBaidu];
    [self requestTwice];
    
    
}


- (void)requestBaidu {
    
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"response == %@", response);
    }];
    
    [task resume];
}

- (void)requestTwice {
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/s?ie=UTF-8&wd=s"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"response == %@", response);
    }];
    
    [task resume];
}

#pragma mark -- Delegate





@end
