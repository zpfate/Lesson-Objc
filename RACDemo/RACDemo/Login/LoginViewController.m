//
//  LoginViewController.m
//  RACDemo
//
//  Created by Twisted Fate on 2022/6/13.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
@interface LoginViewController ()

@property (nonatomic, strong) LoginViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self bindViewModel];
}

- (void)bindViewModel {
    

    RAC(self.viewModel, account) = self.userNameTF.rac_textSignal;
    RAC(self.viewModel, pwd) = self.pwdTF.rac_textSignal;
    
}


- (IBAction)loginAction:(id)sender {
    
    

}
















@end
