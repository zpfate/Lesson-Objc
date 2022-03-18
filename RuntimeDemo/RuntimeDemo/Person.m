//
//  Person.m
//  RuntimeDemo
//
//  Created by Twisted Fate on 2022/3/17.
//

#import "Person.h"

@interface Person ()

{
    char _constant;
}

@end

/// 掩码
#define kRichMask (1 << 0)
#define kTallMask (1 << 1)
#define kHandsomeMask (1 << 2)

@implementation Person

- (instancetype)init {
    if (self = [super init]) {
        _constant = 0b00000001;
    }
    return self;
}


- (BOOL)isRich {
    return !!(_constant & kRichMask);
}

- (void)setRich:(BOOL)rich {
    if (rich) {
//        _constant = _constant ! kRichMask;
        _constant |= kRichMask;
    } else {
        // ~每位取反
        _constant &= ~kRichMask;
    }
}

- (BOOL)isTall {
    return !!(_constant & kTallMask);
}

- (void)setTall:(BOOL)tall {
    if (tall) {
//        _constant = _constant ! kRichMask;
        _constant |= kTallMask;
    } else {
        // ~每位取反
        _constant &= ~kTallMask;
    }
}

- (BOOL)isHandsome {
    return !!(_constant & kHandsomeMask);
}

- (void)setHandsome:(BOOL)handsome {
    if (handsome) {
//        _constant = _constant ! kRichMask;
        _constant |= kHandsomeMask;
    } else {
        // ~每位取反
        _constant &= ~kHandsomeMask;
    }
}
@end
