//
//  DelegateViewController.m
//  RACDemo
//
//  Created by Twisted Fate on 2022/6/13.
//

#import "DelegateViewController.h"
#import "DelegateNextViewController.h"
@interface DelegateViewController ()

@property (nonatomic, strong) RACSubject *subject;

@end

@implementation DelegateViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _subject = [RACSubject subject];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _subject = [RACSubject subject];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    DelegateNextViewController *nextVC = (DelegateNextViewController *)segue.destinationViewController;
    nextVC.subject = self.subject;
    [self.subject subscribeNext:^(id x) {
        NSLog(@"点击了Send Message");
    }];
}

@end
