//
//  ViewController.m
//  SocketDemo
//
//  Created by Twisted Fate on 2022/2/10.
//

#import "ViewController.h"
#import "ServerSocket.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UITextField *portTextField;

@property (weak, nonatomic) IBOutlet UIButton *sendMessageButton;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

- (IBAction)start:(id)sender {
    

    [[ServerSocket shared] startServer:self.portTextField.text];
    
}

@end
