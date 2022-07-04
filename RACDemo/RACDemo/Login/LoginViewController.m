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
    
    // RAC(TARGET, [KEYPATH, [NIL_VALUE]]):用于给某个对象的某个属性绑定
    
    // RAC给某个对象的某个属性绑定一个信号，只要产生信号，就会把信号的内容给对象的属性进行赋值
    RAC(self.viewModel, account) = self.userNameTF.rac_textSignal;
    RAC(self.viewModel, pwd) = self.pwdTF.rac_textSignal;
    
    // RACObserve(TARGET, KEYPATH):监听某个对象的某个属性，返回的是一个信号


}

















@end
