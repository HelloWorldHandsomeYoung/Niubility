//
//  SGRegisterController.m
//  NiubilityApp
//
//  Created by 吕阳 on 16/3/7.
//  Copyright © 2016年 DeveloperYoung. All rights reserved.
//

#import "SGRegisterController.h"
#import "AutoLayoutAnimition.h"
#import "HomePageController.h"
#import "UserManager.h"
#import "HomePageController.h"
#import "SGNavigationController.h"

@interface SGRegisterController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *verificationCode;
@property (weak, nonatomic) IBOutlet UITextField *passWordField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLine1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLine3;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIView *secondView;

@end

@implementation SGRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置初始动画效果的基础
    [self setupTransform];
    //设置textField自动换行
    [self.phoneNumber addTarget:self action:@selector(phoneNumberAction:) forControlEvents:UIControlEventEditingChanged];
    [self.verificationCode addTarget:self action:@selector(vertificationAction:) forControlEvents:UIControlEventEditingChanged];
    [self.passWordField addTarget:self action:@selector(passWordAction:) forControlEvents:UIControlEventEditingChanged];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - 设置初始动画效果的基础
- (void)setupTransform
{
    self.phoneNumber.delegate = self;
    self.verificationCode.delegate = self;
    
    self.welcomeLabel.transform = CGAffineTransformMakeTranslation(0, -300);
    self.secondView.transform = CGAffineTransformMakeTranslation(1000, 0);
    self.bottomLine1.constant = 0;
    self.bottomLine3.constant = 0;
}
#pragma mark - UITextField方法
//手机号码
- (void)phoneNumberAction:(UITextField *)textField
{
    if (textField.text.length == 11) {
        [self sendMessageAction];
        textField.textColor = [UIColor blackColor];
        [self.verificationCode becomeFirstResponder];
    }
    else
    {
        [self.phoneNumber becomeFirstResponder];
    }
}
//验证码
- (void)vertificationAction:(UITextField *)textField
{
    if (self.phoneNumber.text.length != 11) {
        [self.phoneNumber becomeFirstResponder];
        return;
    }
    if (textField.text.length == 4) {
//        [self verificationCodeAction];
        
        [self.verificationCode resignFirstResponder];
        
    }
    else
    {
        [self.verificationCode becomeFirstResponder];
    }
}
//密码
- (void)passWordAction:(UITextField *)textField
{
    
}

#pragma mark - 页面将要出现，动画
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self viewWillAppearAnimition];
}
- (void)viewWillAppearAnimition
{
    [AutoLayoutAnimition topLabelWith:self.welcomeLabel withView:self.view];
    [AutoLayoutAnimition loginButtonMaskAnimition:self.phoneNumber withBeginTime:0];
    [AutoLayoutAnimition loginButtonMaskAnimition:self.passWordField withBeginTime:0.5];
    [AutoLayoutAnimition loginButtonMaskAnimition:self.registerButton withBeginTime:1];
    [AutoLayoutAnimition midToSide:self.bottomLine1 withView:self.view];
    [AutoLayoutAnimition midToSide:self.bottomLine3 withView:self.view];
}

#pragma mark - 发送验证码方法
- (void)sendMessageAction
{
    
}
#pragma mark - 验证方法
- (void)verificationCodeAction
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 注册成功后的动画效果
- (void)succeededVerificationAnimition
{
    
    
    [AutoLayoutAnimition backZeroLayoutConstraint:self.bottomLine3 withView:self.view];
    [AutoLayoutAnimition backZeroLayoutConstraint:self.bottomLine1 withView:self.view];
    sleep(1);
    [AutoLayoutAnimition thirdLogin:self.secondView withView:self.view withTimeInterval:1];
//    [AutoLayoutAnimition backZeroLayoutConstraint:self.bottomLine1 withView:self.secondView];
//    [AutoLayoutAnimition backZeroLayoutConstraint:self.bottomLine3 withView:self.secondView];
}
#pragma mark - 注册
- (IBAction)registerButton:(UIButton *)sender {

    [self succeededVerificationAnimition];
    
}
#pragma mark - 回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
