//
//  ViewController.m
//  NativeFlutterDemo
//
//  Created by Twisted Fate on 2021/5/27.
//

#import "ViewController.h"
#import <Flutter/Flutter.h>
#import "AppDelegate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)goFlutter:(id)sender {
    
    NSLog(@"go flutter");
    
    
    AppDelegate *delegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    FlutterEngine *engine = delegate.flutterEngine;
    
    [delegate.channel sendMessage:@"test1"];
    
    FlutterViewController *vc = [[FlutterViewController alloc] initWithEngine:engine nibName:nil bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
