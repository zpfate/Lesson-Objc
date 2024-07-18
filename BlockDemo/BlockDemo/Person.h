//
//  Person.h
//  BlockDemo
//
//  Created by Twisted Fate on 2022/2/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) void(^block)(void);
- (void)call;
- (void)blockDemo;

@end

NS_ASSUME_NONNULL_END
