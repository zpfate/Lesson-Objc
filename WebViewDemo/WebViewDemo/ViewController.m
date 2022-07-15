//
//  ViewController.m
//  WebViewDemo
//
//  Created by Twisted Fate on 2022/7/15.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
@interface ViewController ()

@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.wkWebView];
    
    [self loadWebView];
    
}

- (void)loadWebView {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http:www.baidu.com"]];
    [self.wkWebView loadRequest:request];
}


- (WKWebView *)wkWebView {
    
    if (!_wkWebView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    }
    return _wkWebView;
}

@end
