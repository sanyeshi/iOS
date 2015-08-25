//
//  JobDetailViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/5/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "InternDetailViewController.h"
#import "InternDetailView.h"
#import "CompanyDetailViewController.h"
#import "LoginNavigationController.h"
#import "AlertView.h"
#import "InternHttp.h"
#import "EmployeeHttp.h"
#import "Intern.h"
#import "Account.h"
#import "MBProgressHUD.h"

@interface InternDetailViewController () <InternDetailViewDelegate>
{
    Intern * _intern;
    BOOL     _isFavorite;
}
@end

@implementation InternDetailViewController


- (instancetype)initWithInternId:(NSUInteger) internId
{
    self = [super init];
    if (self)
    {
        self.internId=internId;
    }
    return self;
}


- (instancetype)initWithIntern:(Intern *) intern
{
    self = [super init];
    if (self)
    {
        _internId=intern.Id;
        _intern=intern;
    }
    return self;
}


-(void)loadView
{
    self.internDetailView=[[InternDetailView alloc] init];
    _internDetailView.backgroundColor=GlobalTableViewBackgroundColor;
    _internDetailView.internDetailDelegate=self;
    self.view=_internDetailView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"实习详情";
    [self requestData];
}

#pragma mark -- 请求数据
-(void) requestData
{
    if (_intern)
    {
        [_internDetailView setIntern:_intern];
        return;
    }
    //请求数据
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = @"努力加载中";
    [hud show:YES];
    [InternHttp getInternWithId:_internId success:^(Intern *intern)
     {
         _intern=intern;
         _internId=intern.Id;
         [_internDetailView setIntern:intern];
         [hud removeFromSuperview];
     }
    fail:^
    {
         [hud removeFromSuperview];
    }];

}

#pragma mark - 公司详情
-(void) internDetailView:(InternDetailView *)internDetailView didClickCompanyInfoButton:(UIButton *)companyInfoButton
{
    CompanyDetailViewController * companyDetailViewController=[[CompanyDetailViewController alloc] initWithCompany:_intern.company];
    [self.navigationController pushViewController:companyDetailViewController animated:YES];
}

-(void) internDetailView:(InternDetailView *)internDetailView didClickApplicateButton:(UIButton *)applicateButton
{
    NSLog(@"applicate");
}


#pragma mark -视图即将出现
-(void) viewWillAppear:(BOOL)animated
{
    Account * account=[Account shareInstance];
    if (account.isLogin)
    {
        //查询是否已关注
        [EmployeeHttp employeeIsFavoriteWithType:@"intern" typeId:_internId success:^(BOOL isFavorite)
         {
             _isFavorite=isFavorite;
             NSString * title=@"收藏";
             if (_isFavorite)
             {
                 title=@"取消收藏";
             }
             NSDictionary * attr=[NSDictionary dictionaryWithObjectsAndKeys:GlobalBigFont,NSFontAttributeName,nil];
             UIBarButtonItem * rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(addFavorite:)];
             [rightBarButtonItem  setTitleTextAttributes:attr forState:UIControlStateNormal];
             self.navigationItem.rightBarButtonItem=rightBarButtonItem;
             
         }fail:nil];
    }
}

-(void) addFavorite:(UIBarButtonItem *) barButtonItem
{
    //添加收藏
    if(!_isFavorite)
    {
        Account * account=[Account shareInstance];
        if (!account.isLogin)
        {
            LoginNavigationController * loginNavigationController=[[LoginNavigationController alloc] init];
            [self presentViewController:loginNavigationController animated:YES completion:nil];
        }
        else
        {
            [EmployeeHttp employeeAddFavoriteWithType:@"intern" typeId:_internId success:^(NSDictionary *dict)
             {
                 NSString * info=[dict valueForKey:@"info"];
                 if ([@"success" isEqualToString:info])
                 {
                     _isFavorite=YES;
                     AlertView * alertView=[[AlertView alloc] init];
                     alertView.title=@"收藏成功";
                     [alertView show];
                     self.navigationItem.rightBarButtonItem.title=@"取消收藏";
                 }
                 else
                 {
                     AlertView * alertView=[[AlertView alloc] init];
                     alertView.title=[NSString stringWithFormat:@"收藏失败:%@",[dict valueForKey:@"info"]];
                     [alertView show];
                 }
             } fail:^
             {
             }];
        }
    }
    else
    {
        //取消收藏
        [EmployeeHttp employeeDeleteFavoriteWithType:@"intern" typeId:_internId success:^(NSDictionary *dict)
         {
             NSString * info=[dict valueForKey:@"info"];
             if ([@"success" isEqualToString:info])
             {
                 _isFavorite=NO;
                 AlertView * alertView=[[AlertView alloc] init];
                 alertView.title=@"取消收藏成功";
                 [alertView show];
                 self.navigationItem.rightBarButtonItem.title=@"收藏";
             }
             else
             {
                 AlertView * alertView=[[AlertView alloc] init];
                 alertView.title=[NSString stringWithFormat:@"取消收藏失败:%@",[dict valueForKey:@"info"]];
                 [alertView show];
             }
         } fail:^
         {
             
         }];
    }
}
@end
