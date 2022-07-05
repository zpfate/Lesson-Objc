//
//  MVPViewController.m
//  MVCDemo
//
//  Created by Twisted Fate on 2022/7/5.
//

#import "MVPViewController.h"
#import "MVPTableViewCell.h"

@interface MVPViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MVPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark -- Delegate && DataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MVPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(MVPTableViewCell.class) forIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


#pragma mark -- Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _tableView;
}


@end
