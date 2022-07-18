//
//  PreloadWebViewController.m
//  WebViewDemo
//
//  Created by Twisted Fate on 2022/7/18.
//

#import "PreloadWebViewController.h"
#import "WKWebViewTool/TFWebManager.h"

@interface PreloadWebViewController ()

@end

@implementation PreloadWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [[TFWebManager manager] loadH5:@"https://juejin.cn/post/6915268111872557069" inViewController:self];
    
}

- (void)dealloc {
    
    [[TFWebManager manager] dispose];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
