//
//  JobDetailViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/5/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "JobDetailViewController.h"
#import "JobDetailView.h"
#import "CompanyDetailViewController.h"
#import "JobHttp.h"
#import "EmployeeHttp.h"
#import "Job.h"
#import "Account.h"
#import "LoginNavigationController.h"
#import "MBProgressHUD.h"
#import "AlertView.h"

@interface JobDetailViewController () <JobDetailViewDelegate>
{
    Job * _job;
    BOOL  _isFavorite;
    BOOL  _isApplied;
}
@end

@implementation JobDetailViewController


- (instancetype)initWithJobId:(NSUInteger) jobId
{
    self = [super init];
    if (self)
    {
        self.jobId=jobId;
    }
    return self;
}

- (instancetype)initWithJob:(Job *) job
{
    self = [super init];
    if (self)
    {
        _jobId=_job.Id;
        _job=job;
    }
    return self;
}

-(void)loadView
{
    self.jobDetailView=[[JobDetailView alloc] init];
    _jobDetailView.backgroundColor=GlobalTableViewBackgroundColor;
    _jobDetailView.jobDetailDelegate=self;
    self.view=_jobDetailView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"兼职详情";
    [self requestData];
}

#pragma mark -- 请求数据
-(void) requestData
{
    if (_job)
    {
        _jobId=_job.Id;
        [_jobDetailView setJob:_job];
        return;
    }
    //请求数据
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = @"努力加载中";
    [hud show:YES];
    [JobHttp getJobWithId:_jobId success:^(Job *job)
     {
         _jobId=job.Id;
         _job=job;
         [_jobDetailView setJob:_job];
         [hud removeFromSuperview];
     }
    fail:^
    {
         [hud removeFromSuperview];
    }];
}

#pragma mark - 显示公司详情
-(void) jobDetailView:(JobDetailView *)jobDetailView didClickCompanyInfoButton:(UIButton *)companyInfoButton
{
    CompanyDetailViewController * companyDetailViewController=[[CompanyDetailViewController alloc] initWithCompany:_job.company];
    [self.navigationController pushViewController:companyDetailViewController animated:YES];
}


#pragma mark -申请工作
-(void) jobDetailView:(JobDetailView *)jobDetailView didClickApplicateButton:(UIButton *)applicateButton
{
    Account * account=[Account shareInstance];
    if (!account.isLogin)
    {
        LoginNavigationController * loginNavigationController=[[LoginNavigationController alloc] init];
        [self presentViewController:loginNavigationController animated:YES completion:nil];
    }
    else
    {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hud];
        hud.labelText = @"申请中";
        [hud show:YES];
        [EmployeeHttp applicationJobWithJobId:_job.Id success:^(NSDictionary *dict)
         {
             [hud removeFromSuperview];
             NSString * info=[dict valueForKey:@"info"];
             if ([@"success" isEqualToString:info])
             {
                 AlertView * alertView=[[AlertView alloc] init];
                 alertView.title=@"申请成功";
                 [alertView show];
                 Job * job=[[Job alloc] initWithDict:[dict valueForKey:@"object"]];
                 _job=job;
                 [_jobDetailView setJob:_job];
                 [_jobDetailView setIsApplied:YES];
             }
             else
             {
                 AlertView * alertView=[[AlertView alloc] init];
                 alertView.title=[NSString stringWithFormat:@"申请失败:%@",[dict valueForKey:@"info"]];
                 [alertView show];
             }
         } fail:^
         {
             [hud removeFromSuperview];
         }];
    }
}


#pragma mark -视图即将出现
-(void) viewWillAppear:(BOOL)animated
{
    Account * account=[Account shareInstance];
    if (account.isLogin)
    {
        //查询是否已关注
        [EmployeeHttp employeeIsFavoriteWithType:@"job" typeId:_jobId success:^(BOOL isFavorite)
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

        } fail:nil];
        
        //查询是否已申请
        [EmployeeHttp isJobAppliedWithJobId:_jobId success:^(BOOL isApplied)
        {
            _isApplied=isApplied;
            if (_isApplied)
            {
                _jobDetailView.isApplied=isApplied;
            }
        } fail:nil];
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
            [EmployeeHttp employeeAddFavoriteWithType:@"job" typeId:_jobId success:^(NSDictionary *dict)
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
        [EmployeeHttp employeeDeleteFavoriteWithType:@"job" typeId:_jobId success:^(NSDictionary *dict)
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
