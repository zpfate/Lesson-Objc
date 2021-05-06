//
//  main.m
//  PredicateDemo
//
//  Created by Twisted Fate on 2021/3/17.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        
        /// 不同方式创建谓词实例比较
//        NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF CONTAINS 'world'"];
//        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", @"world"];
//        NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@" argumentArray:@[@"world"]];
//
//        NSLog(@"predicate1谓词表达式:%@", predicate1.predicateFormat);
//        NSLog(@"predicate2谓词表达式:%@", predicate2.predicateFormat);
//        NSLog(@"predicate3谓词表达式:%@", predicate3.predicateFormat);
        
//        NSString *str = @"Hello, world";
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS 'world'"];
//        NSLog(@"谓词评估结果:%hhd",[predicate evaluateWithObject:str]);
        
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS $variable"];
//        predicate = [predicate predicateWithSubstitutionVariables:@{@"variable":@"world"}];
//        NSLog(@"谓词表达式为%@", [predicate predicateFormat]);


//        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSArray * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
//                // 通过evaluatedObject和bindings来判断是否过滤
//                if ([evaluatedObject containsObject:[bindings objectForKey:@"key"]]) {
//                    return YES;
//                } else {
//                    return NO;
//                }
//            }];
//        BOOL result = [predicate evaluateWithObject:@[@"1", @"2"] substitutionVariables:@{@"key":@"2"}];
//        NSLog(@"谓词评估结果%hhd", result);
        
//        NSString *name = @"name";
//        NSString *value = @"value";
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS %@", name, value];
//        NSLog(@"谓词表达式%@", [predicate predicateFormat]);
//        BOOL result = [predicate evaluateWithObject:@{@"name" : @"value111"}];
//        NSLog(@"谓词结果为%hhd", result);

        
        // BETWEEN
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF BETWEEN {200, 250}"];
        NSLog(@"谓词评估结果:%hhd",  [predicate evaluateWithObject:@(212)]);
        
    }
    return 0;
}
