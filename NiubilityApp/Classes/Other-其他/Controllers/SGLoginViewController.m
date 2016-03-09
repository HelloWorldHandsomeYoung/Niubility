//
//  SGLoginViewController.m
//  NiubilityApp
//
//  Created by 王辉 on 16/3/1.
//  Copyright © 2016年 DeveloperYoung. All rights reserved.
//

#import "SGLoginViewController.h"
#import "SGViewController.h"
#import "UserManager.h"
#import "AutoLayoutAnimition.h"

@interface SGLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;

@property (weak, nonatomic) IBOutlet UITextField *passwardField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetPassWordButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginButtonConstrains;


@property (weak, nonatomic) IBOutlet UIButton *QQButton;
@property (weak, nonatomic) IBOutlet UIButton *weiboButton;
@property (weak, nonatomic) IBOutlet UIButton *WeChatButton;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIView *leftLine;
@property (weak, nonatomic) IBOutlet UIView *rightLine;



@end

@implementation SGLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"填写手机号";
    self.phoneNumField.keyboardType = UIKeyboardTypeNumberPad;
    self.passwardField.secureTextEntry = YES;
    self.passwardField.clearButtonMode = UITextFieldViewModeAlways;
    self.phoneNumField.clearButtonMode = UITextFieldViewModeAlways;
    
    [self addLeftView];
    [self changeButtonCornerRadius];
    
    self.QQButton.transform = CGAffineTransformMakeTranslation(0, 800);
    self.weiboButton.transform = CGAffineTransformMakeTranslation(0, 800);
    self.WeChatButton.transform = CGAffineTransformMakeTranslation(0, 800);
    
    self.phoneNumField.transform = CGAffineTransformMakeTranslation(0, -200);
    self.passwardField.transform = CGAffineTransformMakeTranslation(0, -200);
    
    self.loginButtonConstrains.constant = 0;

    // Do any additional setup after loading the view from its nib.
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [AutoLayoutAnimition thirdLogin:self.QQButton withView:self.view withTimeInterval:0];
    [AutoLayoutAnimition thirdLogin:self.weiboButton withView:self.view withTimeInterval:0.5];
    [AutoLayoutAnimition thirdLogin:self.WeChatButton withView:self.view withTimeInterval:1];
    
    [AutoLayoutAnimition thirdLogin:self.phoneNumField withView:self.view withTimeInterval:0];
    [AutoLayoutAnimition thirdLogin:self.passwardField withView:self.view withTimeInterval:0.5];
    
    [AutoLayoutAnimition midToSide:self.loginButtonConstrains withView:self.view];
    
    [AutoLayoutAnimition loginButtonMaskAnimition:self.forgetPassWordButton withBeginTime:1];
    
    [AutoLayoutAnimition loginButtonMaskAnimition:self.leftLine withBeginTime:-0.5];
    [AutoLayoutAnimition loginButtonMaskAnimition:self.textLabel withBeginTime:0];
    [AutoLayoutAnimition loginButtonMaskAnimition:self.rightLine withBeginTime:0.5];
    
    
    self.navigationController.navigationBarHidden = NO;
}


#pragma mark - 触摸空白处回收键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.phoneNumField resignFirstResponder];
    [self.passwardField resignFirstResponder];
}

#pragma mark - 登录响应事件
#pragma mark 手机号登录响应事件
- (IBAction)loginAction:(UIButton *)sender {
    AVObject *user = [[UserManager shareInstance]userLoginWithUserName:self.phoneNumField.text PassWord:self.passwardField.text];
    if (user != NULL) {
        [[UserManager shareInstance]startClient];
        [self.navigationController presentViewController:[[SGViewController alloc]init] animated:YES completion:nil];
    }else
    {
        UIView *view = [[UIView alloc]init];
        view.width = 120;
        view.height = 30;
        view.center = CGPointMake(self.view.centerX, 130);
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.width, view.height)];
        label.text = @"账号密码错误！";
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:15];
        [view addSubview:label];
        
        [self.view addSubview:view];
        [UIView animateWithDuration:1 animations:^{
            view.alpha = 0;
        }];;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [view removeFromSuperview];
        });
    }
}

#pragma mark QQ登录响应事件
- (IBAction)loginByQQ:(UIButton *)sender {
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         
             SGViewController *svc = [[SGViewController alloc]init];
             
             [self presentViewController:svc animated:YES completion:nil];
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}

#pragma mark 新浪登录响应事件
- (IBAction)loginByWeibo:(UIButton *)sender {
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             
             SGViewController *svc = [[SGViewController alloc]init];
             
             [self presentViewController:svc animated:YES completion:nil];
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}

#pragma mark 微信登录响应事件
- (IBAction)loginByWeChat:(UIButton *)sender {
}


#pragma mark 忘记密码响应时间
- (IBAction)forgetPassward:(UIButton *)sender {
}

#pragma mark - 修改button圆角
- (void)changeButtonCornerRadius {
    self.loginButton.masksToBoundsWH = YES;
    self.loginButton.cornerRadiusWH = 23;
    self.QQButton.masksToBoundsWH = YES;
    self.QQButton.cornerRadiusWH = 25;
    self.weiboButton.masksToBoundsWH = YES;
    self.weiboButton.cornerRadiusWH = 25;
    self.WeChatButton.masksToBoundsWH = YES;
    self.WeChatButton.cornerRadiusWH = 25;
}

#pragma mark 给帐号密码输入框添加左视图
- (void)addLeftView {
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 45)];
    nameLabel.text = @"帐号";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.phoneNumField addSubview:nameLabel];
    self.phoneNumField.leftView = nameLabel;;
    self.phoneNumField.leftViewMode = UITextFieldViewModeAlways;
    
    
    UILabel *passwardLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 45)];
    passwardLabel.text = @"密码";
    passwardLabel.textAlignment = NSTextAlignmentCenter;
    [self.passwardField addSubview:passwardLabel];
    self.passwardField.leftView = passwardLabel;;
    self.passwardField.leftViewMode = UITextFieldViewModeAlways;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
