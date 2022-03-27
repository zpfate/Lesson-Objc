//
//  main.m
//  Demo-super
//
//  Created by Twisted Fate on 2022/3/25.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Person.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        Student *student = [[Student alloc] init];
        
        /*
         类方法的实现和实例方法不一样
         */
        NSLog(@"%d", [[NSObject class] isKindOfClass:[NSObject class]]); // 1
        NSLog(@"%d", [[NSObject class] isMemberOfClass:[NSObject class]]); // 0
        NSLog(@"%d", [[Person class] isKindOfClass:[Person class]]); // 0
        NSLog(@"%d", [[Person class] isMemberOfClass:[Person class]]); // 0
    }
    return 0;
}
