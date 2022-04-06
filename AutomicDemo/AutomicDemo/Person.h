//
//  Person.h
//  AutomicDemo
//
//  Created by Twisted Fate on 2022/4/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@end

/*
 nonatomic和atomic
 
 atomic: 原子性
 // 给属性加上atomic修饰,可以保证属性的getter和setter都是原子性操作,也就是保证setter和getter内部是线程同步的
 
 */

NS_ASSUME_NONNULL_END
