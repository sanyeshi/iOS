//
//  MainViewController.m
//  parttime
//
//  Created by 孙硕磊 on 3/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "HomeRootViewController.h"
#import "HomeMoreView.h"
#import "HomeContentViewController.h"
#import "CompanyTableViewController.h"
#import "ProfileRootViewController.h"

#import "Account.h"
#import "LoginNavigationController.h"

@interface HomeRootViewController () <HomeMoreViewDelegate>
{
    HomeMoreView    * _moreView;
    
}

@end
@implementation HomeRootViewController

#pragma mark 视图加载完毕
-(void) viewDidLoad
{
    [super viewDidLoad];
    self.title=@"首页";
    //more
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(more:)];
    //表格
    CGFloat tableViewX=0;
    CGFloat tableViewY=0;
    CGFloat tableViewW=self.view.frame.size.width;
    CGFloat tableViewH=self.view.frame.size.height-tableViewY-self.tabBarController.tabBar.frame.size.height;
    HomeContentViewController * homeContentViewController=[[HomeContentViewController alloc] init];
    homeContentViewController.tableView.frame=CGRectMake(tableViewX,tableViewY,tableViewW,tableViewH);
    [self addChildViewController:homeContentViewController];
    [self.view addSubview:homeContentViewController.tableView];
}

#pragma mark -更多视图
-(void) more:(UIBarButtonItem *) barBUttonItem
{
    if (_moreView==nil)
    {
        _moreView=[[HomeMoreView alloc] init];
        _moreView.delegate=self;
        [self.view addSubview:_moreView];
    }
    
    if (_moreView.hidden)
    {
        [_moreView show];
    }
    else
    {
        [_moreView hideWithAnimation];
    }
}

-(void) homeMoreView:(HomeMoreView *)homeMoreView didSelectedItemIndex:(NSInteger)index
{
    [_moreView hide];
    //找找实习
    if (index==0)
    {
        [self.tabBarController setSelectedIndex:1];
    }
    //名企招聘
    else if(index==1)
    {
        CompanyTableViewController * companyTableViewController=[[CompanyTableViewController alloc] init];
        [self.navigationController pushViewController:companyTableViewController animated:NO];
    }
    //我的职位
    else
    {
        Account * account=[Account shareInstance];
        if (!account.isLogin)
        {
            LoginNavigationController * loginNavigationController=[[LoginNavigationController alloc] init];
            [self presentViewController:loginNavigationController animated:YES completion:nil];
        }
        else
        {
            [self.tabBarController setSelectedIndex:3];
            UINavigationController * navigationController=self.tabBarController.viewControllers[3];
            ProfileRootViewController * profileRootViewController=(ProfileRootViewController *)navigationController.
            childViewControllers[0];
            [profileRootViewController setIsEnterJobCenterViewController:YES];
        }
    }
}

-(void) viewDidDisappear:(BOOL)animated
{
    [_moreView hide];
}

@end
