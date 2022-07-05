//
//  Person.m
//  RACDemo
//
//  Created by Twisted Fate on 2022/7/4.
//

#import "Person.h"

@implementation Person

+ (instancetype)personWithDict:(NSDictionary *)dict {
    Person *p = [[Person alloc] init];
    [p setValuesForKeysWithDictionary:dict];
    return p;
}

@end
