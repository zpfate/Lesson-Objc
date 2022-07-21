//
//  SimpleViewController.m
//  RACDemo
//
//  Created by Twisted Fate on 2022/6/13.
//

#import "SimpleViewController.h"
#import "Person.h"

@interface SimpleViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *data;

@end

@implementation SimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.data = @{@"RACSignal" : @"rac_signal",
//                  @"RACSubject" : @"rac_subject",
//                  @"RACReplaySubject" : @"rac_replaySubject",
//                  @"RACTuple/RACSequence" : @"rac_sequence",
//                  @"RACCommand" : @"rac_command",
//                  @"RACMulticastConnection" : @"rac_multicastConnection",
//                  @"FlatternMap" : @"rac_flatternMap",
//                  @"Concat" : @"rac_concat",
//                  @"Then" : @"rac_then"
//                };
    
    self.data = @[
        @"RACSignal",
        @"RACSubject"
    ];
    
    [self.view addSubview:self.tableView];
}



#pragma mark -- UITableViewDelegate && UITableDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *key = self.data.allKeys[indexPath.row];
    SEL sel = NSSelectorFromString(self.data[key]);
    
    if ([self respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:sel];
#pragma clang diagnostic pop
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    NSString *key = self.data.allKeys[indexPath.row];
    cell.textLabel.text = key;
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
