//
//  SimpleViewController.m
//  RACDemo
//
//  Created by Twisted Fate on 2022/6/13.
//

#import "SimpleViewController.h"

@interface SimpleViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) NSArray *selectors;

@end

@implementation SimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.data = @[@"RACSignal", @"RACSubject", @"RACReplaySubject", @"RACTuple"];
    self.selectors = @[@"rac_signal", @"rac_subject", @"rac_replaySubject", @""];

    [self.view addSubview:self.tableView];
    
}

- (void)rac_signal {
    // 1.创建信号，首先把didSubscribe保存到信号中，还不会触发。
    // 2.当信号被订阅，也就是调用signal的subscribeNext:nextBlock
    // 2.2 subscribeNext内部会创建订阅者subscriber，并且把nextBlock保存到subscriber中。
    // 2.1 subscribeNext内部会调用siganl的didSubscribe
    // 3.siganl的didSubscribe中调用[subscriber sendNext:@1];
    // 3.1 sendNext底层其实就是执行subscriber的nextBlock
    
    /// 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        /// 每当有订阅者订阅信号的时候,就会调用block
        
        /// 发送信号
        [subscriber sendNext:@1];
        
        /// 如果不在发送数据,最好设置发送信号完成,内部会自动调用[RACDisposable disposable]取消订阅信号
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            /// 信号发送完成或者发送错误,会执行block
            
            /// 执行完成block之后, 当前信号就不在订阅了
            NSLog(@"信号被销毁");
        }];
        
    }];
    
    /// 订阅信号,才会激活信号
    [signal subscribeNext:^(id x) {
       
        /// 每当有信号发出数据,就会调用
        NSLog(@"接收到数据:%@", x);
    }];
}

- (void)rac_subject {
    // RACSubject:底层实现和RACSignal不一样。
        // 1.调用subscribeNext订阅信号，只是把订阅者保存起来，并且订阅者的nextBlock已经赋值了。
        // 2.调用sendNext发送信号，遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
    /// 创建信号
    RACSubject *subject = [RACSubject subject];
    
    [subject subscribeNext:^(id x) {
        NSLog(@"第一个订阅者%@",x);
    }];
    
    [subject subscribeNext:^(id x) {
        NSLog(@"第二个订阅者%@",x);
    }];
    /// 发送信号
    [subject sendNext:@"1"];
}



- (void)rac_replaySubject {
    // RACReplaySubject:底层实现和RACSubject不一样。
       // 1.调用sendNext发送信号，把值保存起来，然后遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
       // 2.调用subscribeNext订阅信号，遍历保存的所有值，一个一个调用订阅者的nextBlock

       // 如果想当一个信号被订阅，就重复播放之前所有值，需要先发送信号，在订阅信号。
       // 也就是先保存值，在订阅值。
    
    // 1.创建信号
      RACReplaySubject *replaySubject = [RACReplaySubject subject];

      // 2.发送信号
      [replaySubject sendNext:@1];
      [replaySubject sendNext:@2];

      // 3.订阅信号
      [replaySubject subscribeNext:^(id x) {
          NSLog(@"第一个订阅者接收到的数据%@",x);
      }];

      // 订阅信号
      [replaySubject subscribeNext:^(id x) {

          NSLog(@"第二个订阅者接收到的数据%@",x);
      }];
}

- (void)rac_tuple {
    
}


#pragma mark -- UITableViewDelegate && UITableDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SEL sel = NSSelectorFromString(self.selectors[indexPath.row]);
    if ([self respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:sel];
#pragma clang diagnostic pop
    }
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
