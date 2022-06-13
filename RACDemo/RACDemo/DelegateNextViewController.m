//
//  DelegateNextViewController.m
//  RACDemo
//
//  Created by Twisted Fate on 2022/6/13.
//

#import "DelegateNextViewController.h"
#
@interface DelegateNextViewController ()

@end

@implementation DelegateNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)sendMessage:(id)sender {
    [self.subject sendNext:nil];
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
