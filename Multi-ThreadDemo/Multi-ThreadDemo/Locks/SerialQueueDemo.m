//
//  SerialQueueDemo.m
//  Multi-ThreadDemo
//
//  Created by Twisted Fate on 2022/4/6.
//

#import "SerialQueueDemo.h"

@interface SerialQueueDemo ()

@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation SerialQueueDemo

- (instancetype)init {
    if (self = [super init]) {
        self.queue = dispatch_queue_create("ticket", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (void)_saleTicket {
  
    dispatch_sync(self.queue, ^{
        [super _saleTicket];
    });
}

- (void)_saveMoney {

    dispatch_sync(self.queue, ^{
        [super _saveMoney];
    });
    
}

- (void)_drawMoney {
    
    dispatch_sync(self.queue, ^{
        [super _drawMoney];
    });
    


}

@end
