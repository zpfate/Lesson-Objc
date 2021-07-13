//
//  FlutterManager.m
//  NativeFlutterDemo
//
//  Created by Twisted Fate on 2021/7/13.
//

#import "FlutterManager.h"

@interface FlutterManager ()

@end

@implementation FlutterManager

+ (instancetype)shared {
    return [[[self class] alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static FlutterManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [super allocWithZone:zone];
        }
    });
    return  manager;
}



@end
