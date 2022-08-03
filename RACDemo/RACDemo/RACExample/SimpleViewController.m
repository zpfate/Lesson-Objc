//
//  SimpleViewController.m
//  RACDemo
//
//  Created by Twisted Fate on 2022/6/13.
//

#import "SimpleViewController.h"
#import "Person.h"
#import "RACExample.h"
@interface SimpleViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) RACExample *example;

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
        @"RACSubject",
        @"RACReplaySubject",
        @"RACTuple_RACSequence",
        @"RACCommand",
        @"",
        @"",
    ];
    
    [self.view addSubview:self.tableView];
}



#pragma mark -- UITableViewDelegate && UITableDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *methodName = self.data[indexPath.row];
    methodName = [NSString stringWithFormat:@"__%@", methodName];
    
    SEL sel = NSSelectorFromString(methodName);

    if ([self.example respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
         [self.example performSelector:sel];
#pragma clang diagnostic pop
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    NSString *example = self.data[indexPath.row];
    cell.textLabel.text = example;
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

- (RACExample *)example {
    if (!_example) {
        _example = [RACExample new];
    }
    return _example;
}

@end
