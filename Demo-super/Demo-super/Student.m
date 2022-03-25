//
//  Student.m
//  Demo-super
//
//  Created by Twisted Fate on 2022/3/25.
//

#import "Student.h"

@implementation Student

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSLog(@"%@", [self class]);
        NSLog(@"%@", [self superclass]);
        NSLog(@"---------------------");
        NSLog(@"%@", [super class]);
        NSLog(@"%@", [super superclass]);

        
    }
    return self;
}

@end
