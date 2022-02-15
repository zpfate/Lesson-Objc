//
//  ViewController.m
//  ClientDemo
//
//  Created by Twisted Fate on 2022/2/15.
//

#import "ViewController.h"
#import "ClientSocket.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *hostTF;
@property (weak, nonatomic) IBOutlet UITextField *portTF;
@property (weak, nonatomic) IBOutlet UITextField *messageTV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)startConnect:(id)sender {
    [[ClientSocket shared] startConnect:@"192.168.40.25" port:@"8080"];
}


- (IBAction)sendMessage:(id)sender {
    
    static NSInteger count = 0;
    [[ClientSocket shared] sendMessage:[NSString stringWithFormat:@"%zd", count]];
    count++;
}
@end
