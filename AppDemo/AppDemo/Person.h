//
//  Person.h
//  AppDemo
//
//  Created by Twisted Fate on 2022/3/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
- (void)print;
@end

NS_ASSUME_NONNULL_END
