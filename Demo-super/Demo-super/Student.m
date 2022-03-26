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
        
        /** super
         super调用的是objc_msgSendSuper
         该方法需要传入一个objc_super的结构体
         结构体objc有两个参数:
                receiver: 方法接收者
                superClass: 从父类寻找方法的实现
         */
        NSLog(@"%@", [self class]); // Student
        NSLog(@"%@", [self superclass]); // Person
        NSLog(@"---------------------");
        NSLog(@"%@", [super class]); // Student
        NSLog(@"%@", [super superclass]); // Person

        
    }
    return self;
}

@end
