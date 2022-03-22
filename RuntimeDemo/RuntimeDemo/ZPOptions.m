//
//  ZPOptions.m
//  RuntimeDemo
//
//  Created by Twisted Fate on 2022/3/22.
//

#import "ZPOptions.h"

@implementation ZPOptions

- (void)setOptions:(ZPOptionsEnum)options {
    if (options & ZPOptionsNew) {
        NSLog(@"包含ZPOptionsNew");
    }
    if (options & ZPOptionsOld) {
        NSLog(@"包含ZPOptionsOld");
    }
    if (options & ZPOptionsAll) {
        NSLog(@"包含ZPOptionsAll");
    }
}

@end
