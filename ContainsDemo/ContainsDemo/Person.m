//
//  Person.m
//  ContainsDemo
//
//  Created by Twisted Fate on 2022/4/27.
//

#import "Person.h"

@implementation Person

//- (BOOL)isEqual:(id)object {
//    if (object == nil) return NO;
//    NSObject *obj = object;
//    if ([obj isKindOfClass:Person.class]) {
//        Person *p = (Person *)obj;
//        if ([self.name isEqualToString:p.name]) {
//            return YES;
//        }
//    }
//    return NO;
//}

- (NSUInteger)hash {
    return self.name.hash;
}

@end
