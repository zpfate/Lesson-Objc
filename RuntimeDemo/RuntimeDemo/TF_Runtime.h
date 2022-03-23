//
//  TF_Runtime.h
//  RuntimeDemo
//
//  Created by Twisted Fate on 2022/3/23.
//
#import <Foundation/Foundation.h>

#ifndef TF_Runtime_h
#define TF_Runtime_h
# if __arm64__
#   define ISA_MASK        0x0000000ffffffff8ULL
# elif __x86_64__
#   define ISA_MASK        0x00007ffffffffff8ULL
#endif

#if __LP64__
typedef unint32_t mask_t;
#else
typedef unint16_t mask_t;
#endif

typedef unitptr_t cache_key_t;

#if __arm__ || __x86_64__ || __i386__



struct bucket_t {
    cache_key_t _key;
    IMP _imp;
}

struct cache_t {
    bucket_t * _buckets;
    maskt_t _mask;
}

struct class_rw_t {
    uint32_t flags;
    uint32_t version;
    const class_ro_t *ro;
    
};

struct objc_class {
    Class isa;
    Class superclass;
    cache_t cache;
    class_data_bits_t bits;
}

#endif /* TF_Runtime_h */
