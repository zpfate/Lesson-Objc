//
//  ViewController.m
//  FlutterDemo
//
//  Created by Twisted Fate on 2021/5/25.
//

#import "ViewController.h"
#import "SceneDelegate.h"
#import <Flutter/Flutter.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)goFlutter:(id)sender {
    
    
    FlutterViewController *flutterViewController =
        [[FlutterViewController alloc] initWithProject:<#(nullable FlutterDartProject *)#> nibName:<#(nullable NSString *)#> bundle:<#(nullable NSBundle *)#>
    [self presentViewController:flutterViewController animated:YES completion:nil];
}

@end
