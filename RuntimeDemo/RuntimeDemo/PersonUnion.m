//
//  PersonUnion.m
//  RuntimeDemo
//
//  Created by Twisted Fate on 2022/3/21.
//

#import "PersonUnion.h"

/// 掩码
#define kRichMask (1 << 0)
#define kTallMask (1 << 1)
#define kHandsomeMask (1 << 2)


@interface PersonUnion ()

union isa_t {

    Class cls;
    uintptr_t bits;
    struct {
        /// 0代表的是普通的指针 存储着Class Meta-Class对象的内存地址
        /// 1代表优化过,使用位域存储更多的信息
        uintptr_t nonpointer        : 1;
        /// 是否有设置过关联对象 如果没有,释放时会更快
        uintptr_t has_assoc         : 1;
        /// 是否有c++的析构函数(.cxx_destruct)  如果没有  释放时会更快
        uintptr_t has_cxx_dtor      : 1;
        /// 存储着Class Meta-Class对象的内存地址信息
        uintptr_t shiftcls          : 44;  /*MACH_VM_MAX_ADDRESS 0x7fffffe00000*/
        /// 用于在调试时分辨对象是否未完成初始化
        uintptr_t magic             : 6;
        /// 是否被弱引用指向过 如果没有 释放时会更快
        uintptr_t weakly_referenced : 1;
        /// 对象是否正在释放
        uintptr_t deallocating      : 1;
        /// 引用计数是否过大无法存储在isa中
        /// 如果为1 那么引用计数会存储在一个叫SideTable的类的属性中
        uintptr_t has_sidetable_rc  : 1;
        /// 里面存储的值是引用计数减1
        uintptr_t extra_rc          : 8; // defined in isa.h
    };
};
{
    /// 共用体的意思是大家共用一个字
    union{
        char bits;
        struct {
            char tall: 1;
            char rich: 1;
            char handsome: 1;
        };
    } _constant;
    
}
@end


@implementation PersonUnion



- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}


- (BOOL)isRich {
    return !!(_constant.bits & kRichMask);
}

- (void)setRich:(BOOL)rich {
    if (rich) {
//        _constant = _constant ! kRichMask;
        _constant.bits |= kRichMask;
    } else {
        // ~每位取反
        _constant.bits &= ~kRichMask;
    }
}

- (BOOL)isTall {
    return !!(_constant.bits & kTallMask);
}

- (void)setTall:(BOOL)tall {
    if (tall) {
//        _constant = _constant ! kRichMask;
        _constant.bits |= kTallMask;
    } else {
        // ~每位取反
        _constant.bits &= ~kTallMask;
    }
}

- (BOOL)isHandsome {
    return !!(_constant.bits & kHandsomeMask);
}

- (void)setHandsome:(BOOL)handsome {
    if (handsome) {
        _constant.bits |= kHandsomeMask;
    } else {
        // ~每位取反
        _constant.bits &= ~kHandsomeMask;
    }
}
@end
