//
//  ViewController.m
//  FlutterBLEDemo
//
//  Created by Twisted Fate on 2021/7/9.
//

#import "ViewController.h"
#import "RRBluetoothUtil.h"
#import <Flutter/Flutter.h>
#import "FlutterManager.h"
typedef void (^RRFlutterReply)(BOOL success, NSDictionary *_Nullable parameters);

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[FlutterManager shared] initFlutterEngine];
}
- (IBAction)startConnect:(id)sender {
    
    
    FlutterEngine *engine = [FlutterManager shared].engine;
    FlutterViewController *flutterVC = [[FlutterViewController alloc] initWithEngine:engine nibName:nil bundle:nil];
    flutterVC.modalPresentationStyle = UIModalPresentationFullScreen;
    
    
    NSMutableDictionary *parameters = NSMutableDictionary.dictionary;
    [parameters setValue:@"zhilun://rentAssetsReceive" forKey:@"pageName"];
    [parameters setValue:@"page" forKey:@"method"];
    
    [[FlutterManager shared].messageChannel sendMessage:parameters reply:^(id  _Nullable reply) {
        
        [self presentViewController:flutterVC animated:YES completion:^ {
           
        }];
    }];
}

- (void)handleReply:(id _Nullable)reply
           callBack:(RRFlutterReply _Nullable)callBack {
    if (reply) {
        if ([reply isKindOfClass:NSDictionary.class]) {
            BOOL success = [[(NSDictionary *)reply valueForKey:@"success"] boolValue];
            if (callBack) {
                callBack(success, (NSDictionary *)reply);
            }
        }
    }
}
@end
