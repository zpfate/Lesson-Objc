//
//  SynchronizeDemo.m
//  Multi-ThreadDemo
//
//  Created by Twisted Fate on 2022/4/6.
//

#import "SynchronizeDemo.h"

@implementation SynchronizeDemo

- (void)_saleTicket {
    
    @synchronized (self) {
        [super _saleTicket];
    }
}

- (void)_saveMoney {
    @synchronized (self) {
        [super _saveMoney];
    }}

- (void)_drawMoney {
    @synchronized (self) {
        [super _drawMoney];
    }}

@end
