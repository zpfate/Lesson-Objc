//
//  ClientViewController.m
//  SocketDemo
//
//  Created by Twisted Fate on 2022/2/14.
//

#import "ClientViewController.h"
#import "ClientSocket.h"
@interface ClientViewController ()

@property (weak, nonatomic) IBOutlet UITextField *ipTextField;

@property (weak, nonatomic) IBOutlet UITextField *portTextField;

@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@end

@implementation ClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing: YES];
    
}

- (IBAction)start:(id)sender {
    
    [[ClientSocket shared] start];
}

- (IBAction)sendMessage:(id)sender {
    
    [[ClientSocket shared] sendMessage:self.contentTextField.text];
}


@end
