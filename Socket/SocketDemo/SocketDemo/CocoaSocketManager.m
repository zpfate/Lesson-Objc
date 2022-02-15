//
//  CocoaSocketManager.m
//  SocketDemo
//
//  Created by Twisted Fate on 2022/2/11.
//

#import "CocoaSocketManager.h"


@interface CocoaSocketManager ()


@end


@implementation CocoaSocketManager

+ (instancetype)manager {
    static CocoaSocketManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[CocoaSocketManager alloc] init];
        }
    });
    return manager;
}


- (void)startServer {
    
    
    
}

@end
