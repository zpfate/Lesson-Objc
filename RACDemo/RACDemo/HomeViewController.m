//
//  HomeViewController.m
//  RACDemo
//
//  Created by Twisted Fate on 2022/6/13.
//

#import "HomeViewController.h"
#import "ViewController.h"
@interface HomeViewController ()

@property (nonatomic, strong) UIButton *customBtn;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.customBtn];
    self.navigationItem.rightBarButtonItem = item;
}


- (void)pushRAC {
    [self.navigationController pushViewController:[ViewController new] animated:YES];
}


- (UIButton *)customBtn {
    if (!_customBtn) {
        _customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_customBtn setTitle:@"rac" forState:UIControlStateNormal];
        [_customBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_customBtn addTarget:self action:@selector(pushRAC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customBtn;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
