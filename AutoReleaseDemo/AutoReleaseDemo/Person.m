//
//  Person.m
//  AutoReleaseDemo
//
//  Created by Twisted Fate on 2022/4/11.
//

#import "Person.h"

@implementation Person

- (void)dealloc
{
    NSLog(@"%s", __func__);
}


@end
