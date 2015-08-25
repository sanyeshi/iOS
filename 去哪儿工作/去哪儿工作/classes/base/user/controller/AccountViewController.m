//
//  AccountViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/23/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "AccountViewController.h"
#import "ResetPasswordViewController.h"

#import "Account.h"
#import "Employee.h"
#import "EmployeeHttp.h"

#import "AccountCell.h"
#import "SSLImageCropperViewController.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"


@interface AccountViewController ()<UIAlertViewDelegate,SSLImageCropperViewControllerDelegate>
{
    Account * _account;
    UIImage * _croppedImage;
}
@end

@implementation AccountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"账户管理";
    self.tableView.backgroundColor=GlobalTableViewBackgroundColor;
    self.tableView.sectionFooterHeight=0;
    
    _account=[Account shareInstance];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return 60.0f;
    }
    return 40.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer=@"tableViewCell";
    AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil)
    {
        cell=[[AccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.section==0)
    {
        cell.titleLabel.text=@"头像";
        cell.rightView=[self getIconView];
    }
    else if(indexPath.section==1)
    {
        cell.titleLabel.text=@"修改密码";
        cell.rightView=nil;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0)
    {
        [self imageCropper];
    }
    //修改密码
    else if (indexPath.section==1)
    {
        ResetPasswordViewController * resetPasswordViewController=[[ResetPasswordViewController alloc] init];
        resetPasswordViewController.title=@"修改密码";
        [self.navigationController pushViewController:resetPasswordViewController animated:YES];
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==1)
    {
        return 60;
    }
    return 0;
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==1)
    {
       return [self getFooterView];
    }
    return nil;
}


#pragma mark -iconView

-(UIView *) getIconView
{
    UIImageView * imageView=[[UIImageView alloc] init];
    imageView.layer.cornerRadius=25.0f;
    imageView.clipsToBounds=YES;
    if (_croppedImage)
    {
        imageView.image=_croppedImage;
    }
    else
    {
        [imageView sd_setImageWithURL:[NSURL URLWithString:_account.employee.imageUrlStr]];
    }
    imageView.frame=CGRectMake(self.view.frame.size.width-100, 5, 50, 50);
    return imageView;
}

#pragma mark -footerView
-(UIView *) getFooterView
{
    UIView * view=[[UIView alloc] init];
    view.backgroundColor=[UIColor clearColor];
    UIButton * button=[[UIButton alloc] init];
    button.backgroundColor=RGBColor(249, 88, 59);
    button.layer.cornerRadius=5.0f;
    button.frame=CGRectMake(10, 20, [[UIScreen mainScreen] bounds].size.width-20, 40);
    button.titleLabel.font=GlobalBoldFont;
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchDown];
    [view addSubview:button];
    return view;
}

#pragma mark -头像选取
-(void) imageCropper
{
    SSLImageCropperViewController * imageCropper=[[SSLImageCropperViewController alloc] init];
    imageCropper.imageCropperViewControllerDelegate=self;
    [self presentViewController:imageCropper animated:YES completion:nil];
}

-(void) sslImageCropperViewController:(SSLImageCropperViewController *)cropper didFinished:(UIImage *)croppedImage
{
    _croppedImage=croppedImage;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    [self dismissViewControllerAnimated:YES completion:^
    {
        [self updateIconWithImage:croppedImage];
    }];
}

-(void) sslImageCropperViewControllerDidCancel:(SSLImageCropperViewController *)cropper
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void) updateIconWithImage:(UIImage *) image
{
    //请求数据
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = @"更新中";
    [hud show:YES];

     [Http uploadImageWithImage:image success:^(NSString * md5)
      {
          if (![md5 isEqualToString:@"fail"])
          {
              [EmployeeHttp updateEmployeeIconWithMD5:md5 success:^(BOOL isSuccess)
              {
                 [hud removeFromSuperview];
                  if (isSuccess)
                  {
                      _account.employee.imageUrlStr=ImageURL(md5);
                      [_account update];
                  }
              }
              fail:^{
                   [hud removeFromSuperview];
              }];
          }
          else
          {
             [hud removeFromSuperview];
          }
      }
     fail:^
     {
         [hud removeFromSuperview];
     }];
}

#pragma mark 退出登陆
-(void) logout
{
    UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认退出", nil];
    [alertView show];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //退出登陆
    if (buttonIndex==1)
    {
        _account.isLogin=false;
        [_account update];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
