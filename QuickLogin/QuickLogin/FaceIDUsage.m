//
//  FaceIDUsage.m
//  QuickLogin
//
//  Created by Twisted Fate on 2022/8/30.
//

#import "FaceIDUsage.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation FaceIDUsage

+ (instancetype)shared {
    static FaceIDUsage *usage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        usage = [[FaceIDUsage alloc] init];
    });
    return usage;
}


- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;;
}


- (void)configre {
    
}

@end
