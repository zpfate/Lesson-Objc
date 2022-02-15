//
//  ClientSocket.m
//  SocketDemo
//
//  Created by Twisted Fate on 2022/2/14.
//

#import "ClientSocket.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

@interface ClientSocket ()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *clientSocket;

@end

@implementation ClientSocket

+ (instancetype)shared {
    
    static ClientSocket *clientSocket = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        clientSocket = [[ClientSocket alloc] init];
    });
    return clientSocket;
}


- (void)start {

    NSError *err = nil;
    [self.clientSocket connectToHost:@"192.168.40.25" onPort:8080 withTimeout:-1 error:&err];
}


- (void)sendMessage:(NSString *)message {
    
    if (message.length > 0) {
        NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
        /// timeOut -1 代表无穷大
        [self.clientSocket writeData:data withTimeout:-1 tag:0];
    } else {
        
    }
}

- (void)receiveData {
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}


#pragma mark -- GCDAsyncSocketDelegate

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {

    NSLog(@"已经链接到服务器");

}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"接收到的数据==%@", text);

}

- (GCDAsyncSocket *)clientSocket {
    if (!_clientSocket) {
        _clientSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return _clientSocket;
}

@end
