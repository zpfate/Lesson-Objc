//
//  ViewController.m
//  WebViewDemo
//
//  Created by Twisted Fate on 2022/7/15.
//

#import "ViewController.h"
#import "WebViewController.h"
#import "PreloadWebViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
}
- (IBAction)commonWebView:(id)sender {
    
    WebViewController *webVC = [[WebViewController alloc] init];
    [self.navigationController pushViewController:webVC animated:YES];
    
}

- (IBAction)preloadWebView:(id)sender {
    
    PreloadWebViewController *preloadVC = [[PreloadWebViewController alloc] init];
    [self.navigationController pushViewController:preloadVC animated:YES];
}


@end
