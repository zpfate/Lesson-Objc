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

@property (nonatomic, strong) NSDictionary *data;

@end

@implementation SimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.data = @{@"RACSignal" : @"rac_signal",
                  @"RACSubject" : @"rac_subject",
                  @"RACReplaySubject" : @"rac_replaySubject",
                  @"RACTuple/RACSequence" : @"rac_sequence",
                  @"RACCommand" : @"rac_command",
                  @"RACMulticastConnection" : @"rac_multicastConnection",
                  @"FlatternMap" : @"rac_flatternMap",
                  @"Concat" : @"rac_concat",
                  @"Then" : @"rac_then"
                };
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

- (void)rac_sequence {
    
    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"aaa", @"bbb", @123]];
    NSString *str = tuple[0];
    NSLog(@"tuple[0] = %@", str);
    
    NSArray *numbers = @[@1, @2, @3, @4, @5];
    // 第一步: 把数组转换成集合RACSequence numbers.rac_sequence
    // 第二步: 把集合RACSequence转换RACSignal信号类, numbers.rac_sequence.signal
    // 第三步: 订阅信号，激活信号，会自动把集合中的所有值，遍历出来。
    [numbers.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    // 遍历字典,遍历出来的键值对会包装成RACTuple(元组对象)
    NSDictionary *dict = @{@"name":@"xmg", @"age":@18};
    [dict.rac_sequence.signal subscribeNext:^(id x) {
        // 解包元组
        RACTupleUnpack(NSString *key, NSString *value) = x;
        NSLog(@"key = %@, value = %@", key, value);
    }];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"json.plist" ofType:nil];
    NSArray *dataArr = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *results = [NSMutableArray array];
    [dataArr.rac_sequence.signal subscribeNext:^(NSDictionary * _Nullable x) {
        Person *p = [Person personWithDict:x];
        [results addObject:p];
    }];
    NSLog(@"results = %@", results);
    
    
    NSArray *mapResults = [[dataArr.rac_sequence map:^id _Nullable(id  _Nullable value) {
        return [Person personWithDict:value];
    }] array];
    NSLog(@"mapResults = %@", mapResults);


}

- (void)rac_command {
    
    // RAC中用于处理事件的类, 可以把事件如何处理, 事件中的数据如何传递, 包装到这个类中, 他可以很方便的监控事件的执行过程
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"执行命令");
        
        // 必须要返回信号 可以直接返回空信号 return [RACSignal empty];
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"请求数据"];
            // 注意:数据传递完, 最好调用SendCompleted,这时命令才执行完毕
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    // 订阅RACCommand中的信号
    [command.executionSignals subscribeNext:^(id x) {
        [x subscribeNext:^(id x) {
            NSLog(@"%@", x);
        }];
    }];
    
    // RAC高级用法
    //  switchToLatest:用于signal of signals，获取signal of signals发出的最新信号,也就是可以直接拿到RACCommand中的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    // 监听命令是否执行完毕 默认回来一次 可以直接跳过 skip表示跳过第一次信号
    [[command.executing skip:1] subscribeNext:^(id x) {
        if ([x boolValue]) {
            NSLog(@"正在执行");
        } else {
            NSLog(@"执行完成");
        }
    }];
    [command execute:@1];
}

- (void)rac_multicastConnection {
    /*
     * 用于当一个信号，被多次订阅时，为了保证创建信号时，避免多次调用创建信号中的block，造成副作用，可以使用这个类处理
     * 创建connect，connect.sourceSignal -> RACSignal(原始信号)  connect.signal -> RACSubject
     * 订阅connect.signal，会调用RACSubject的subscribeNext，创建订阅者，而且把订阅者保存起来，不会执行block。
     * [connect connect]内部会订阅RACSignal(原始信号)，并且订阅者是RACSubject
     * 订阅原始信号，就会调用原始信号中的didSubscribe
     * didSubscribe，拿到订阅者调用sendNext，其实是调用RACSubject的sendNext
     * RACSubject的sendNext,会遍历RACSubject所有订阅者发送信号
     * 因为刚刚第二步，都是在订阅RACSubject，因此会拿到第二步所有的订阅者，调用他们的nextBlock
     */

    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送需求");
        return nil;
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"接收数据");
    }];
    
    [signal subscribeNext:^(id x) {
        NSLog(@"接收数据");
    }];
    // 运行结果，会执行两遍发送请求，也就是每次订阅都会发送一次请求
    // RACMulticastConnection:解决重复请求问题
       // 1.创建信号
       RACSignal *signal2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           
           NSLog(@"发送请求");
           [subscriber sendNext:@1];
           return nil;
       }];
       
       // 2.创建连接
       RACMulticastConnection *connect = [signal2 publish];
       
       // 3.订阅信号，
       // 注意：订阅信号，也不能激活信号，只是保存订阅者到数组，必须通过连接,当调用连接，就会一次性调用所有订阅者的sendNext:
       [connect.signal subscribeNext:^(id x) {
           NSLog(@"订阅者一信号");
       }];
       
       [connect.signal subscribeNext:^(id x) {
           NSLog(@"订阅者二信号");
       }];
       // 4.连接,激活信号
       [connect connect];
}

- (void)rac_flatternMap {
    /* FlatternMap中的Block返回信号。
     * Map中的Block返回对象。
     * 开发中，如果信号发出的值不是信号，映射一般使用Map
     * 开发中，如果信号发出的值是信号，映射一般使用FlatternMap
     */
    
    
    RACSubject *signalOfSignals = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    
//    [[signalOfSignals flattenMap:^RACStream *(id value) {
//        /// 当signalOfsignals的signals发出信号才会调用
//        return  value;
//    }] subscribeNext:^(id x) {
//        //只有signalOfsignals的signal发出信号才会调用，因为内部订阅了bindBlock中返回的信号，也就是flattenMap返回的信号。
//        // 也就是flattenMap返回的信号发出内容，才会调用。
//        NSLog(@"x===%@", x);
//    }];
    [signalOfSignals sendNext:signal];
    [signal sendNext:@1];
}


/// 拼接信号
- (void)rac_concat {
    
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
         [subscriber sendNext:@1];
         [subscriber sendCompleted];
         return nil;
     }];
     RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
         [subscriber sendNext:@2];
         return nil;
     }];
     
     // 把signalA拼接到signalB后，signalA发送完成，signalB才会被激活。
     RACSignal *concatSignal = [signalA concat:signalB];
    [concatSignal subscribeNext:^(id x) {
         
         NSLog(@"%@",x);
         
     }];
     
    // concat底层实现:
   // 1.当拼接信号被订阅，就会调用拼接信号的didSubscribe
   // 2.didSubscribe中，会先订阅第一个源信号（signalA）
   // 3.会执行第一个源信号（signalA）的didSubscribe
   // 4.第一个源信号（signalA）didSubscribe中发送值，就会调用第一个源信号（signalA）订阅者的nextBlock,通过拼接信号的订阅者把值发送出来.
   // 5.第一个源信号（signalA）didSubscribe中发送完成，就会调用第一个源信号（signalA）订阅者的completedBlock,订阅第二个源信号（signalB）这时候才激活（signalB）。
   // 6.订阅第二个源信号（signalB）,执行第二个源信号（signalB）的didSubscribe
   // 7.第二个源信号（signalA）didSubscribe中发送值,就会通过拼接信号的订阅者把值发送出来.
}

- (void)rac_then {
    // then:用于连接两个信号，当第一个信号完成，才会连接then返回的信号
   // 注意使用then，之前信号的值会被忽略掉.
   // 底层实现：1、先过滤掉之前的信号发出的值。2.使用concat连接then返回的信号
   [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
       [subscriber sendNext:@1];
       [subscriber sendCompleted];
       return nil;
   }] then:^RACSignal *{
       return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           [subscriber sendNext:@2];
           return nil;
       }];
   }] subscribeNext:^(id x) {
     
       // 只能接收到第二个信号的值，也就是then返回信号的值
       NSLog(@"%@",x);
   }];
}


- (void)more {
    
    UIView *redV = nil;
    
    UIButton *btn = nil;
    
    // 1.代替代理
       // 需求：自定义redView,监听红色view中按钮点击
       // 之前都是需要通过代理监听，给红色View添加一个代理属性，点击按钮的时候，通知代理做事情
       // rac_signalForSelector:把调用某个对象的方法的信息转换成信号，就要调用这个方法，就会发送信号。
       // 这里表示只要redV调用btnClick:,就会发出信号，订阅就好了。
       [[redV rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(id x) {
           NSLog(@"点击红色按钮");
       }];

       // 2.KVO
       // 把监听redV的center属性改变转换成信号，只要值改变就会发送信号
       // observer:可以传入nil
       [[redV rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {

           NSLog(@"%@",x);

       }];

       // 3.监听事件
       // 把按钮点击事件转换为信号，点击按钮，就会发送信号
       [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

           NSLog(@"按钮被点击了");
       }];

       // 4.代替通知
       // 把监听到的通知转换信号
       [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
           NSLog(@"键盘弹出");
       }];

       // 5.监听文本框的文字改变
      [[UITextField new].rac_textSignal subscribeNext:^(id x) {
          NSLog(@"文字改变了%@",x);
      }];
      
      // 6.处理多个请求，都返回结果的时候，统一做处理.
       RACSignal *request1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           // 发送请求1
           [subscriber sendNext:@"发送请求1"];
           return nil;
       }];
       
       RACSignal *request2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           // 发送请求2
           [subscriber sendNext:@"发送请求2"];
           return nil;
       }];
       
       // 使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。
       [self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[request1,request2]];
}


// 更新UI
- (void)updateUIWithR1:(id)data r2:(id)data1 {
    NSLog(@"更新UI%@  %@",data,data1);
}

- (void)btnClick:(UIView *)sender {
    
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
