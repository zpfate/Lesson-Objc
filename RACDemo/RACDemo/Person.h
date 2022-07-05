//
//  Person.h
//  RACDemo
//
//  Created by Twisted Fate on 2022/7/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) NSInteger age;

+ (instancetype)personWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
