//
//  DataSource.m
//  MVCDemo
//
//  Created by Twisted Fate on 2022/7/6.
//

#import "DataSource.h"
#import "MVPTableViewCell.h"
#import "MVPModel.h"
#import "Present.h"

typedef void(^ConfigureBlock)(MVPTableViewCell *cell, NSIndexPath *indexPath);

@interface DataSource ()

@property (nonatomic, strong) NSString *reuseIdentifer;

@property (nonatomic, copy) ConfigureBlock configreBlock;

@property (nonatomic, strong) Present *present;

@end


@implementation DataSource

- (instancetype)initWithReuseIdentifer:(NSString *)reuseIdentifer configureBlock:(void(^)(MVPTableViewCell *cell, NSIndexPath *indexPath))configureBlock {
    
    if (self = [super init]) {
        _reuseIdentifer = reuseIdentifer;
        _configreBlock = configureBlock;
    }
    return self;
}

- (void)bindPresent:(Present *)present {
    _present = present;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.present.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MVPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifer forIndexPath:indexPath];
    
    MVPModel *model = [self.present modelAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}



@end
