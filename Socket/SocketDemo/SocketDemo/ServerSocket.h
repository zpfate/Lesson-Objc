//
//  ServerSocket.h
//  SocketDemo
//
//  Created by Twisted Fate on 2022/2/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ServerSocket : NSObject

+ (instancetype)shared;

- (void)startServer:(NSString *)port;


@end

NS_ASSUME_NONNULL_END
