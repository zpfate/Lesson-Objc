//
//  ClientSocket.h
//  SocketDemo
//
//  Created by Twisted Fate on 2022/2/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClientSocket : NSObject
+ (instancetype)shared;

- (void)start;

- (void)sendMessage:(NSString *)message;

- (void)receiveData;

@end

NS_ASSUME_NONNULL_END
