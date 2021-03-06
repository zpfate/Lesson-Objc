//
//  HomeViewController.m
//  RACDemo
//
//  Created by Twisted Fate on 2022/6/13.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "SimpleViewController.h"
#import "DelegateViewController.h"
#import "StoryboardExtension.h"
@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) NSArray *pages;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.data = @[@"RAC基础使用",
                  @"RACSubject基础使用(代理 block)",
                  @"RAC KVO/通知/Timer",
                  @"MVVM+RAC登录页Demo",
                
    ];
    self.pages = @[
        [SimpleViewController new],
        [StoryboardExtension initialViewController:@"DelegateViewController"],
        [StoryboardExtension initialViewController:@"KVOViewController"],
        [StoryboardExtension initialViewController:@"LoginViewController"],
    ];
    
    [self.view addSubview:self.tableView];
}


#pragma mark -- UITableViewDelegate && UITableDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIViewController *vc = self.pages[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
