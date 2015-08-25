//
//  RegisterViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/7/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "RegisterViewController.h"
#import "UITextField+LeftView.h"
#import "CheckCodeButton.h"
#import "Http.h"
#import "EmployeeHttp.h"
#import "AlertView.h"
#import "NSString+Validator.h"


#define kMargin 10
#define kTextFiledHeight 40


@interface RegisterViewController ()<UITextFieldDelegate>
{
    UIScrollView *   _scrollView;
    CGPoint          _originalOffset;
    UITextField  *   _currentTextField;
}
@end

@implementation RegisterViewController

- (void)loadView
{
    _scrollView=[[UIScrollView alloc] init];
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.frame=[UIScreen mainScreen].bounds;
    self.view=_scrollView;
    _originalOffset=CGPointMake(0, -64);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"用户注册";
    [self createSubViews];
}

-(void) createSubViews
{
    
    CGFloat width=self.view.frame.size.width;
    CGFloat textFieldX=2*kMargin;
    CGFloat textFieldY=kMargin;
    CGFloat textFieldW=width-4*kMargin;
    CGFloat textFieldH=kTextFiledHeight;
    
    //用户名
    self.usernameTextField=[UITextField textFieldWithTitle:nil placeholder:@"请输入手机号"];
    _usernameTextField.delegate=self;
    _usernameTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    _usernameTextField.keyboardType=UIKeyboardTypeNumberPad;
    _usernameTextField.frame=CGRectMake(textFieldX,textFieldY,textFieldW,textFieldH);
    _usernameTextField.leftView.frame=CGRectMake(0, 0, 20, kTextFiledHeight);
    _usernameTextField.tag=0;
    [self.view addSubview:_usernameTextField];
    
    //密码
    textFieldY+=kTextFiledHeight+kMargin;
    self.passwordTextField=[UITextField textFieldWithTitle:nil placeholder:@"请输入密码"];
    _passwordTextField.delegate=self;
    _passwordTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    _passwordTextField.frame=CGRectMake(textFieldX,textFieldY,textFieldW,textFieldH);
    _passwordTextField.leftView.frame=CGRectMake(0, 0, 20, kTextFiledHeight);
    _passwordTextField.secureTextEntry=YES;
    _passwordTextField.tag=1;
    [self.view addSubview:_passwordTextField];
    
    //确认密码
    textFieldY+=kTextFiledHeight+kMargin;
    self.repasswordTextField=[UITextField textFieldWithTitle:nil placeholder:@"请确认密码"];
    _repasswordTextField.delegate=self;
    _repasswordTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    _repasswordTextField.frame=CGRectMake(textFieldX,textFieldY,textFieldW,textFieldH);
    _repasswordTextField.leftView.frame=CGRectMake(0, 0, 20, kTextFiledHeight);
    _repasswordTextField.secureTextEntry=YES;
    _repasswordTextField.tag=2;
    [self.view addSubview:_repasswordTextField];

    //验证码
    textFieldY+=kTextFiledHeight+kMargin;
    self.checkCodeTextField=[UITextField textFieldWithTitle:nil placeholder:@"请输入验证码"];
    _checkCodeTextField.delegate=self;
    _checkCodeTextField.keyboardType=UIKeyboardTypeNumberPad;
    _checkCodeTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    _checkCodeTextField.frame=CGRectMake(textFieldX,textFieldY,textFieldW,textFieldH);
    _checkCodeTextField.leftView.frame=CGRectMake(0, 0, 20, kTextFiledHeight);
    _checkCodeTextField.tag=3;
    [self.view addSubview:_checkCodeTextField];
    textFieldY+=kTextFiledHeight;
    [self customInputAccessoryView];
    //发送验证码按钮
    CGFloat btnX=textFieldX;
    CGFloat btnY=textFieldY+kMargin;
    CGFloat btnW=(textFieldW-kMargin)*0.5;
    CGFloat btnH=textFieldH;
    
    self.sendCheckCodeButton=[[CheckCodeButton alloc] init];
    _sendCheckCodeButton.titleFont=GlobalFont;
    _sendCheckCodeButton.titleColor=GlobalWhiteTextColor;
    _sendCheckCodeButton.frame=CGRectMake(btnX,btnY,btnW,btnH);
    _sendCheckCodeButton.backgroundColor=GlobalTintColor;
    [_sendCheckCodeButton setCheckCodeStyleForState:CheckCodeStateNormal];
    __weak RegisterViewController * temp=self;
    _sendCheckCodeButton.sendCheckCodeBlock=^(){
      [Http sendRegisterCheckCodeWithPhone:temp.usernameTextField.text];
    };
    [self.view addSubview:_sendCheckCodeButton];
    
    //注册按钮
    btnX+=btnW+kMargin;
    self.registerButton=[[UIButton alloc] init];
    _registerButton.frame=CGRectMake(btnX,btnY,btnW,btnH);
    _registerButton.titleLabel.font=GlobalFont;
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [_registerButton setTitleColor:GlobalWhiteTextColor forState:UIControlStateNormal];
    [_registerButton addTarget:self action:@selector(userRegister:) forControlEvents:UIControlEventTouchDown];
    _registerButton.frame=CGRectMake(btnX,btnY,btnW,btnH);
    _registerButton.backgroundColor=GlobalTintColor;

    [self.view addSubview:_registerButton];
    
}


-(void) customInputAccessoryView
{
    if (iPhone4S)
    {
        _usernameTextField.inputAccessoryView=[self toolBar];
        _passwordTextField.inputAccessoryView=[self toolBar];
        _repasswordTextField.inputAccessoryView= [self toolBar];
        _checkCodeTextField.inputAccessoryView=[self toolBar];
    }
}
#pragma mark -注册
-(void) userRegister:(UIButton *) button
{
    [self resignFirstResponder];
    //数据校验
    NSString * phone=_usernameTextField.text;
    NSString * password=_passwordTextField.text;
    NSString * repassword=_repasswordTextField.text;
    NSString * checkcode=_checkCodeTextField.text;
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
    if (![password isEqualToString:repassword])
    {
        AlertView *alertView=[[AlertView alloc] init];
        alertView.title=@"密码不一致";
        [alertView show];
        return;
    }
    if(checkcode.length==0)
    {
        AlertView *alertView=[[AlertView alloc] init];
        alertView.title=@"验证码为空";
        [alertView show];
        return;
    }

    [EmployeeHttp employeeRegisterWithPhone:_usernameTextField.text password:_passwordTextField.text checkcode:_checkCodeTextField.text success:^(NSDictionary *dict)
    {
        NSString * info=[dict valueForKey:@"info"];
        AlertView * alertView=[[AlertView alloc] init];
        alertView.title=info;
        [alertView show];
        if([info isEqualToString:@"注册成功"])
        {
          [NSThread sleepForTimeInterval:2.0f];
          [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:^
    {
    }];
}

- (BOOL)resignFirstResponder
{
    [_usernameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_repasswordTextField resignFirstResponder];
    [_checkCodeTextField resignFirstResponder];
    return [super resignFirstResponder];
}


-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    _currentTextField=textField;
    textField.layer.borderWidth=0.5f;
    textField.layer.borderColor=[GlobalTintColor CGColor];
    if (iPhone4S)
    {
        CGFloat top=_currentTextField.tag*(kMargin+kTextFiledHeight);
        [UIView animateWithDuration:0.3f animations:^
         {
             _scrollView.contentOffset=CGPointMake(0, top+_originalOffset.y);
         }];
    }
}
-(void) textFieldDidEndEditing:(UITextField *)textField
{
    textField.layer.borderWidth=1.0f;
    textField.layer.borderColor=[GlobalSeparatorColor CGColor];
    if (iPhone4S)
    {
        [UIView animateWithDuration:0.3f animations:^
         {
             _scrollView.contentOffset=_originalOffset;
         }];
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(UIToolbar *) toolBar
{
    //辅助视图
    UIBarButtonItem *flexibleItem=[[UIBarButtonItem alloc]  initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneItem=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(done:)];
    doneItem.tintColor=[UIColor blackColor];
    UIToolbar * toolbar=[[UIToolbar alloc] init];
    toolbar.translucent=NO;
    toolbar.backgroundColor=[UIColor whiteColor];
    toolbar.frame=CGRectMake(0, 0, self.view.frame.size.width, 44);
    [toolbar setItems:@[flexibleItem,doneItem]];
    return toolbar;
}

-(void) done:(UIBarButtonItem *) barButtonItem
{
    [_currentTextField resignFirstResponder];
}


@end
