//
//  BaseDemo.h
//  Multi-ThreadDemo
//
//  Created by Twisted Fate on 2022/4/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseDemo : NSObject

/*
 * 售票模拟
 */
- (void)ticketTest;
/**
 * 售票
 */
- (void)_saleTicket;

/*
 * 存钱取钱模拟
 */
- (void)moneyTest;
/*
 * 存钱
 */
- (void)_saveMoney;
/*
 * 取钱
 */
- (void)_drawMoney;


@end

NS_ASSUME_NONNULL_END
