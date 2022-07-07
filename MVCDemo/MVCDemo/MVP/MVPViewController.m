//
//  MVPViewController.m
//  MVCDemo
//
//  Created by Twisted Fate on 2022/7/5.
//

#import "MVPViewController.h"
#import "MVPTableViewCell.h"
#import "Present.h"
#import "DataSource.h"

@interface MVPViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) DataSource *dataSource;

@property (nonatomic, strong) Present *present;

@end

@implementation MVPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.dataSource bindPresent:self.present];
    
    
    __weak typeof(self) weakSelf = self;
    [self.present loadData:^(NSArray * _Nonnull arr) {
        [weakSelf reloadUI:arr];
    }];
    
    [self setupViews];

}

- (void)setupViews {
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self.dataSource;
    
}

- (void)reloadUI:(NSArray *)arr {
    
    [self.tableView reloadData];
}

#pragma mark -- Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView registerClass:MVPTableViewCell.class forCellReuseIdentifier:NSStringFromClass(MVPTableViewCell.class)];
    }
    return _tableView;
}

- (DataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[DataSource alloc] initWithReuseIdentifer:NSStringFromClass(MVPTableViewCell.class) configureBlock:nil];
    }
    return _dataSource;
}

- (Present *)present {
    if (!_present) {
        _present = [[Present alloc] init];
    }
    return _present;
}
@end
