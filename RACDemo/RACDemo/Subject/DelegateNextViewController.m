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

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (IBAction)sendMessage:(id)sender {
    
    [self.subject sendNext:@"1"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (RACSubject *)subject {
    if (!_subject) {
        _subject = [RACSubject subject];
    }
    return _subject;
}

@end
