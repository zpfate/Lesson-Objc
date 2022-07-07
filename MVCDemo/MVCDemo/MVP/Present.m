//
//  Present.m
//  MVCDemo
//
//  Created by Twisted Fate on 2022/7/5.
//

#import "Present.h"
#import "MVPModel.h"

@interface Present ()

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation Present

- (void)loadData:(void(^)(NSArray *arr))completion {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"json" ofType:@"plist"];
    NSArray *data = [NSArray arrayWithContentsOfFile:filePath];
    for (NSDictionary *dict in data) {
        MVPModel *model = [MVPModel initWithDict:dict];
        [self.data addObject:model];
    }
    
    
    if (completion) {
        completion(data);
    }
}

- (NSInteger)count {
    return self.data.count;
}

- (MVPModel *)modelAtIndex:(NSInteger)index {
    return self.data[index];
}

- (NSMutableArray *)data {
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

@end
