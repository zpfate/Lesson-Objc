//
//  ZPOptions.h
//  RuntimeDemo
//
//  Created by Twisted Fate on 2022/3/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ZPOptionsNone = 0,
    ZPOptionsNew = 1 << 0,
    ZPOptionsOld = 1 << 1,
    ZPOptionsAll = 1 << 2,
} ZPOptionsEnum;


@interface ZPOptions : NSObject

@end

NS_ASSUME_NONNULL_END
