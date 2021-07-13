//
//  ViewController.m
//  NativeFlutterDemo
//
//  Created by Twisted Fate on 2021/5/27.
//

#import "ViewController.h"
#import "FlutterManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[FlutterManager shared] initMessageChannel];
}

- (IBAction)goFlutter:(id)sender {
    
    NSLog(@"go flutter");
    [[FlutterManager shared] presentFlutterViewController];
    
    
}

@end
