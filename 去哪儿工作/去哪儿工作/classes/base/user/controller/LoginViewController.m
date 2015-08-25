//
//  LoginViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/7/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ResetPasswordViewController.h"
#import "UITextField+LeftView.h"
#import "Account.h"
#import "Employee.h"
#import "EmployeeHttp.h"
#import "MBProgressHUD.h"
#import "AlertView.h"
#import "NSString+Validator.h"

#define kMargin 10
#define kMargin_2 5
#define kTextFiledHeight 40

@interface LoginViewController ()<UITextFieldDelegate>
{
    UILabel  * _tipLabel;
    UIButton * _registerButton;
    UIButton * _forgetPasswordButton;
}
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"登陆";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    [self createSubViews];
}

-(void) createSubViews
{
    
    CGFloat width=self.view.frame.size.width;
    CGFloat textFieldX=2*kMargin;
    CGFloat textFieldY=80;
    CGFloat textFieldW=width-4*kMargin;
    CGFloat textFieldH=kTextFiledHeight;
    
    Account * account=[Account shareInstance];
    //用户名
    self.usernameTextField=[UITextField textFieldWithLeftViewImageName:@"account.png" placeholder:@"手机"];
    _usernameTextField.delegate=self;
    _usernameTextField.text=account.employee.phone;
    _usernameTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    _usernameTextField.keyboardType=UIKeyboardTypeNumberPad;
    _usernameTextField.frame=CGRectMake(textFieldX,textFieldY,textFieldW,textFieldH);
    _usernameTextField.leftView.frame=CGRectMake(0, 0, 40, kTextFiledHeight);
    [self.view addSubview:_usernameTextField];
    
    //密码
    textFieldY+=kTextFiledHeight+kMargin;
    self.passwordTextField=[UITextField textFieldWithLeftViewImageName:@"password.png" placeholder:@"密码"];
    _passwordTextField.delegate=self;
    _passwordTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    _passwordTextField.frame=CGRectMake(textFieldX,textFieldY,textFieldW,textFieldH);
    _passwordTextField.leftView.frame=CGRectMake(0, 0, 40, kTextFiledHeight);
    _passwordTextField.secureTextEntry=YES;
    [self.view addSubview:_passwordTextField];
    
    //登陆按钮
    CGFloat btnX=textFieldX;
    CGFloat btnY=CGRectGetMaxY(_passwordTextField.frame)+kMargin;
    CGFloat btnW=textFieldW;
    CGFloat btnH=textFieldH;
    self.loginButton=[[UIButton alloc] init];
    _loginButton.titleLabel.font=GlobalFont;
    [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [_loginButton setTitleColor:GlobalWhiteTextColor forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchDown];
    _loginButton.frame=CGRectMake(btnX,btnY,btnW,btnH);
    _loginButton.backgroundColor=GlobalTintColor;
    [self.view addSubview:_loginButton];

    
     //快速注册按钮
     btnY=CGRectGetMaxY(_loginButton.frame)+kMargin_2;
     btnW=btnW*0.5;
     btnH=20;
    _registerButton=[self buttonWithTitle:@"快速注册"];
    _registerButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    _registerButton.frame=CGRectMake(btnX,btnY,btnW,btnH);
    [_registerButton addTarget:self action:@selector(userRegister) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_registerButton];
    
    //忘记密码按钮
    btnX=CGRectGetMaxX(_registerButton.frame);
    _forgetPasswordButton=[self buttonWithTitle:@"忘记密码"];
    _forgetPasswordButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    _forgetPasswordButton.frame=CGRectMake(btnX,btnY,btnW, btnH);
    [_forgetPasswordButton addTarget:self action:@selector(userForgetPassword) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_registerButton];
    [self.view addSubview:_forgetPasswordButton];
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    textField.layer.borderWidth=0.5f;
    textField.layer.borderColor=[GlobalTintColor CGColor];
}
-(void) textFieldDidEndEditing:(UITextField *)textField
{
    textField.layer.borderWidth=1.0f;
    textField.layer.borderColor=[GlobalSeparatorColor CGColor];
}

#pragma mark - 登陆注册按钮
-(UIButton *) buttonWithTitle:(NSString *) title
{
    UIButton * btn=[[UIButton alloc] init];
    btn.titleLabel.font=GlobalSmallFont;
    [btn setTitleColor:GlobalBackgroundTextColor forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}
#pragma mark -注册
-(void) userRegister
{
    RegisterViewController * registerViewController=[[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}
#pragma mark -忘记密码
-(void) userForgetPassword
{
    ResetPasswordViewController * resetPasswordViewController=[[ResetPasswordViewController alloc] init];
    resetPasswordViewController.title=@"忘记密码";
    [self.navigationController  pushViewController:resetPasswordViewController animated:YES];
}
- (BOOL)resignFirstResponder
{
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    return [super resignFirstResponder];
}
#pragma mark 事件
-(void) login
{
    //退出键盘
    [self resignFirstResponder];
    //数据校验
    NSString * phone=_usernameTextField.text;
    NSString * password=_passwordTextField.text;
    if (![phone isPhoneNumber])
    {
        AlertView *alertView=[[AlertView alloc] init];
        alertView.title=@"手机号错误";
        [alertView show];
        return;
    }
    if(password.length==0)
    {
        AlertView *alertView=[[AlertView alloc] init];
        alertView.title=@"密码为空";
        [alertView show];
        return;
    }
    //登陆提示
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = @"登陆中";
    [hud show:YES];
    [EmployeeHttp getEmployeeWithPhone:phone password:password success:^(Employee *employee)
     {
         [hud removeFromSuperview];
         if (employee==nil)
         {
             AlertView *alertView=[[AlertView alloc] init];
             alertView.title=@"手机号或密码错误";
             [alertView show];
         }
         else
         {
             Account * account=[Account shareInstance];
             account.isLogin=YES;
             account.phone=phone;
             account.password=password;
             account.employee=employee;
             [account archivedToDocument];
             [self dismissViewControllerAnimated:YES completion:nil];
         }
     } fail:^
     {
          [hud removeFromSuperview];   
     }];

}

-(void) dismiss
{
    [self resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
