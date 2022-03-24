//
//  Person.m
//  MessageForwardingDemo
//
//  Created by Twisted Fate on 2022/3/24.
//

#import "Person.h"
#import <objc/runtime.h>
#import "Cat.h"
@implementation Person


- (void)instanceTest {
    NSLog(@"%s-%s", sel_getName(_cmd), __func__);
}

+ (void)classTest {
    NSLog(@"%s-%s", sel_getName(_cmd), __func__);
}

/// 动态方法解析
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if (sel == @selector(test)) {
//        Method method = class_getInstanceMethod(self, @selector(instanceTest));
//        class_addMethod(
//                        self,
//                        sel,
//                        method_getImplementation(method),
//                        method_getTypeEncoding(method)
//                        );
//        return YES;
//       
//    }
//    return [super resolveInstanceMethod:sel];
//}
//
//+ (BOOL)resolveClassMethod:(SEL)sel {
//    
//    if (sel == @selector(test)) {
//        Method method = class_getClassMethod(self, @selector(classTest));
//        class_addMethod(
//                        object_getClass(self),
//                        sel,
//                        method_getImplementation(method),
//                        method_getTypeEncoding(method)
//                        );
//        return YES;
//    }
//    return [super resolveClassMethod:sel];
//}


// 消息转发
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(test)) {
//        return [[Cat alloc] init];
        return nil;
    }
    return [super forwardingTargetForSelector: aSelector];
}

// 方法签名: 返回值类型 参数类型
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(test)) {
        Method method = class_getInstanceMethod(object_getClass(self), @selector(instanceTest));
        
        return [NSMethodSignature signatureWithObjCTypes:method_getTypeEncoding(method)];
    }
    return [super methodSignatureForSelector:aSelector];
}

// NSInvocation封装了一个方法调用
// anInvocation.target 方法调用者
// anInvocation.selector 方法名
// [anInvocation getArgument:NULL atIndex:0] 方法参数
- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    anInvocation.target = [[Cat alloc] init];
//    [anInvocation invoke];
    [anInvocation invokeWithTarget:[[Cat alloc] init]];
}

@end
