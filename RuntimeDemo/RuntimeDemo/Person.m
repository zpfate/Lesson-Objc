//
//  Person.m
//  RuntimeDemo
//
//  Created by Twisted Fate on 2022/3/17.
//

#import "Person.h"

@interface Person ()
{
    /// 位域只占一个字节
    struct {
        char tall: 1;
        char rich: 1;
        char handsome: 1;
    } _constant; // 0b0000 0001
//    char _constant;
}

@end

/// 掩码
#define kRichMask (1 << 0)
#define kTallMask (1 << 1)
#define kHandsomeMask (1 << 2)

@implementation Person

- (instancetype)init {
    if (self = [super init]) {
//        _constant = 0b00000001;
    }
    return self;
}





- (BOOL)isRich {
    return _constant.rich;
//    return !!(_constant & kRichMask);
}

- (void)setRich:(BOOL)rich {
//    if (rich) {
////        _constant = _constant ! kRichMask;
//        _constant |= kRichMask;
//    } else {
//        // ~每位取反
//        _constant &= ~kRichMask;
//    }
    _constant.rich = rich;
}

- (BOOL)isTall {
//    return !!(_constant & kTallMask);
    return !!_constant.tall;
}

- (void)setTall:(BOOL)tall {
//    if (tall) {
////        _constant = _constant ! kRichMask;
//        _constant |= kTallMask;
//    } else {
//        // ~每位取反
//        _constant &= ~kTallMask;
//    }
    _constant.tall = tall;
}

- (BOOL)isHandsome {
//    return !!(_constant & kHandsomeMask);
    return !!_constant.handsome;
}

- (void)setHandsome:(BOOL)handsome {
//    if (handsome) {
////        _constant = _constant ! kRichMask;
//        _constant |= kHandsomeMask;
//    } else {
//        // ~每位取反
//        _constant &= ~kHandsomeMask;
//    }
    _constant.handsome = handsome;
}
@end
