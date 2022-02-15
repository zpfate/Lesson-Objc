//
//  FlutterManager.m
//  NativeFlutterDemo
//
//  Created by Twisted Fate on 2021/7/13.
//

#import "FlutterManager.h"
#import "AppDelegate.h"
#import "TFFlutterViewController.h"
@interface FlutterManager ()
@property (nonatomic, strong) FlutterEngine *engine;
@property (nonatomic, strong) FlutterBasicMessageChannel *messageChannel;
@end

@implementation FlutterManager

+ (instancetype)shared {
    return [[[self class] alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static FlutterManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [super allocWithZone:zone];
        }
    });
    return  manager;
}

- (void)initMessageChannel {
    
    self.engine = [[FlutterEngine alloc] initWithName:@"testEngine"];
    [self.engine run];
    self.messageChannel = [FlutterBasicMessageChannel messageChannelWithName:@"com.nativeflutterdemo.www" binaryMessenger:self.engine.binaryMessenger];
    [self.messageChannel setMessageHandler:^(id  _Nullable message, FlutterReply  _Nonnull callback) {
        FlutterStandardTypedData *data = message;
        NSLog(@"message === %@", data.data);
    }];
}


- (void)presentFlutterViewController {
    
    TFFlutterViewController *flutterVC = [[TFFlutterViewController alloc] initWithEngine:self.engine nibName:nil bundle:nil];
    flutterVC.modalPresentationStyle = UIModalPresentationFullScreen;
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *vc = delegate.window.rootViewController;
    [vc presentViewController:flutterVC animated:YES completion:nil];
}

@end
