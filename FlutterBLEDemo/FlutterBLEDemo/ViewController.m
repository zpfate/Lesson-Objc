//
//  ViewController.m
//  FlutterBLEDemo
//
//  Created by Twisted Fate on 2021/7/9.
//

#import "ViewController.h"
#import "RRBluetoothUtil.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)startConnect:(id)sender {
    
    [[RRBluetoothUtil shared] initBluetooth];
}


@end