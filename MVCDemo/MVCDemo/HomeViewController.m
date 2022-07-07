//
//  HomeViewController.m
//  MVCDemo
//
//  Created by Twisted Fate on 2022/7/5.
//

#import "HomeViewController.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSDictionary *dict;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HomeViewController

#pragma mark -- Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Home";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.dict = @{
        @"MVP": @"MVPViewController",
    };
    
    
}







#pragma mark -- Private Methods







#pragma mark -- Public Methods






#pragma mark -- Delegate && DataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    NSArray *keys = self.dict.allKeys;
    NSString *key = keys[indexPath.row];
    cell.textLabel.text = key;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dict.allKeys.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *keys = self.dict.allKeys;
    NSString *key = keys[indexPath.row];
    NSString *value = self.dict[key];
    
    Class cls = NSClassFromString(value);
    if (cls) {
        
        [self.navigationController pushViewController:[cls new] animated:YES];
    }

    
}


#pragma mark -- Getter && Setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end
