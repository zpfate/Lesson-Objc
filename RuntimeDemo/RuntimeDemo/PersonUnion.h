//
//  PersonUnion.h
//  RuntimeDemo
//
//  Created by Twisted Fate on 2022/3/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonUnion : NSObject

- (BOOL)isRich;
- (void)setRich:(BOOL)rich;
- (BOOL)isTall;
- (void)setTall:(BOOL)tall;
- (BOOL)isHandsome;
- (void)setHandsome:(BOOL)handsome;
@end

NS_ASSUME_NONNULL_END
