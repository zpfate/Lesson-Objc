//
//  ServerSocket.m
//  SocketDemo
//
//  Created by Twisted Fate on 2022/2/14.
//

#import "ServerSocket.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>
@interface ServerSocket ()<GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *serverSocket;

@property (nonatomic, strong) GCDAsyncSocket *linkedSocket;

@end

@implementation ServerSocket

+ (instancetype)shared {
    
    static ServerSocket *serverSocket = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serverSocket = [[ServerSocket alloc] init];
    });
    return serverSocket;
}

- (void)startServer:(NSString *)port {
    
    NSError *error;
    
    BOOL result = [self.serverSocket acceptOnPort:port.intValue error:&error];
    if (result) {
        NSLog(@"Socket 启动成功");
    } else {
        NSLog(@"启动失败, error === %@", error.description);
    }
}


#pragma mark -- GCDAsyncSocketDelegate

- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    
    self.linkedSocket = newSocket;
    [self.linkedSocket readDataWithTimeout:-1 tag:0];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
    /// 接收到数据
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"接收到数据===%@", text);
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    
}


#pragma mark -- Getter

- (GCDAsyncSocket *)serverSocket {
    if (!_serverSocket) {
        _serverSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return _serverSocket;
}

@end
