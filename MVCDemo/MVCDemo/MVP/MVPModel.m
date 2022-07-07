//
//  MVPModel.m
//  MVCDemo
//
//  Created by Twisted Fate on 2022/7/5.
//

#import "MVPModel.h"

@implementation MVPModel

+ (instancetype)initWithDict:(NSDictionary *)dict {
    MVPModel *model = [[MVPModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"undefined Key: %@", key);
}

@end
