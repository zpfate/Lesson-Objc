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
        
        
        
        NSLog(@"%d", [[NSObject class] isKindOfClass:[NSObject class]]);
        NSLog(@"%d", [[NSObject class] isMemberOfClass:[NSObject class]]);
        NSLog(@"%d", [[Person class] isKindOfClass:[Person class]]);
        NSLog(@"%d", [[Person class] isMemberOfClass:[Person class]]);
    }
    return 0;
}
