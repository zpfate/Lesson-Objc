//
//  BaseDemo.m
//  Multi-ThreadDemo
//
//  Created by Twisted Fate on 2022/4/1.
//

#import "BaseDemo.h"

@interface BaseDemo ()

@property (nonatomic, assign) int money;

@property (nonatomic, assign) int ticketsCount;

@end

@implementation BaseDemo


- (void)ticketTest {
 
    self.ticketsCount = 15;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            sleep(0.2);
            self.ticketsCount--;
            NSLog(@"还剩---%d张票", self.ticketsCount);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self _saleTicket];
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5; i++) {
            [self _saleTicket];
        }
    });
}

- (void)_saleTicket {
    
    int oldTicketCount = self.ticketsCount;
    sleep(0.2);
    oldTicketCount--;
    self.ticketsCount = oldTicketCount;
    NSLog(@"还剩---%d张票", self.ticketsCount);
}


- (void)moneyTest {
    
    self.money = 100;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self _saveMoney];
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 10; i++) {
            [self _drawMoney];
        }
    });
}

- (void)_saveMoney {
    int oldMoney = self.money;
    sleep(0.2);
    oldMoney += 50;
    self.money = oldMoney;
    NSLog(@"存了50,余额%d - %@", self.money, [NSThread currentThread]);
}

- (void)_drawMoney {
    int oldMoney = self.money;
    sleep(0.2);
    oldMoney -= 20;
    self.money = oldMoney;
    NSLog(@"取了20,余额%d - %@", self.money, [NSThread currentThread]);
}



@end
