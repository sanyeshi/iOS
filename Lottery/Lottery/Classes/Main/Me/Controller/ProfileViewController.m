//
//  ProfileViewController.m
//  Lottery
//
//  Created by 孙硕磊 on 6/24/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ProfileViewController.h"
#import "SettingViewController.h"

@interface ProfileViewController ()
{
    UIImageView * _imageView;
    UIButton    * _loginBtn;
}
@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"我的彩票";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting:)];
    self.view.backgroundColor=LotteryBackgroundColor;
    //创建子控件
    _imageView=[[UIImageView alloc] init];
    _imageView.contentMode=UIViewContentModeScaleAspectFit;
    _imageView.image=[UIImage imageNamed:@"LoginScreen"];
    _imageView.frame=CGRectMake(0, 0, self.view.frame.size.width, 200);
    [self.view addSubview:_imageView];
    
    
    _loginBtn=[[UIButton alloc] init];
    _loginBtn.titleEdgeInsets=UIEdgeInsetsMake(-19, 0, 0, 0);
    _loginBtn.titleLabel.font=[UIFont systemFontOfSize:12.0f];
    [_loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[[UIImage imageNamed:@"RedButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(40, 10, 10, 10) ]forState:UIControlStateNormal];
    [_loginBtn setBackgroundImage:[[UIImage imageNamed:@"RedButtonPressed"] resizableImageWithCapInsets:UIEdgeInsetsMake(40, 10, 10,10)]forState:UIControlStateSelected];
    _loginBtn.frame=CGRectMake(10, 200, self.view.frame.size.width-20, 50);
    [self.view addSubview:_loginBtn];
    

}

-(void) setting:(UIBarButtonItem *) barButtonItem
{
    SettingViewController * settingViewController=[[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingViewController animated:YES];
}


@end
