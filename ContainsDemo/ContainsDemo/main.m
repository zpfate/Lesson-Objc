//
//  main.m
//  ContainsDemo
//
//  Created by Twisted Fate on 2022/4/27.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        Person *p1 = [Person new];
        p1.name = @"xxx1";
        
        
        Person *p2 = [Person new];
        p2.name = @"xxx2";
        
        Person *p3 = [Person new];
        p3.name = @"xxx3";
        
        Person *p4 = [Person new];
        p4.name = @"xxx1";
        
        NSArray *arr = @[p1, p2, p3];
      
        NSLog(@"---%d--", [arr containsObject:p4]);
        
    }
    return 0;
}



