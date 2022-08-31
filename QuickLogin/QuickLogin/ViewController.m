//
//  ViewController.m
//  QuickLogin
//
//  Created by Twisted Fate on 2022/8/30.
//

#import "ViewController.h"
#import "FaceIDUsage.h"
@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)configure:(id)sender {
    
    [[FaceIDUsage shared] configre];
    
}


@end
