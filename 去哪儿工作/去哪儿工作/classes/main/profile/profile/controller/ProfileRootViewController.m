//
//  ProfileMainViewController.m
//  parttime
//
//  Created by 孙硕磊 on 3/27/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ProfileRootViewController.h"
#import "ProfileHeaderView.h"
#import "MultiTextLabel.h"
#import "SeparatorCell.h"
#import "ProfileCellItem.h"
#import "AccountViewController.h"
#import "JobCenterViewController.h"
#import "ReceiptCenterViewController.h"
#import "CardCenterViewController.h"
#import "FavoriteCenterViewController.h"
#import "ResumeCenterViewController.h"
#import "Account.h"
#import "Employee.h"
#import "EmployeeHttp.h"

#import "LoginNavigationController.h"
#import "UIImageView+WebCache.h"

@interface ProfileRootViewController ()<ProfileHeaderViewDelegate>
{
    NSArray * _items;
}
@end
@implementation ProfileRootViewController

/*
 
 */

- (void)viewDidLoad
{
    //设定返回按钮
    self.navigationItem.backBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"我"
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:nil
                                                                           action:nil];
    //数据
    ProfileCellItem * myJobItem=[[ProfileCellItem alloc] initWithIconName:@"profile_my_job.png" title:@"我的职位" willShowViewControllerClass:[JobCenterViewController class]];
    ProfileCellItem * myReceiptItem=[[ProfileCellItem alloc] initWithIconName:@"profile_my_receipt.png" title:@"我的收款" willShowViewControllerClass:[ReceiptCenterViewController class]];
    ProfileCellItem * myCardItem=[[ProfileCellItem alloc] initWithIconName:@"profile_my_card.png" title:@"我的打卡" willShowViewControllerClass:[CardCenterViewController class]];
    ProfileCellItem * myFavoriteItem=[[ProfileCellItem alloc] initWithIconName:@"profile_my_favorite.png" title:@"我的收藏" willShowViewControllerClass:[FavoriteCenterViewController class]];
    ProfileCellItem * myResumeItem=[[ProfileCellItem alloc] initWithIconName:@"profile_my_resume.png" title:@"我的简历" willShowViewControllerClass:[ResumeCenterViewController class]];
    _items=@[myJobItem,myReceiptItem,myCardItem,myFavoriteItem,myResumeItem];

    self.tableView.sectionHeaderHeight=0;
    self.tableView.sectionFooterHeight=10;
    self.tableView.backgroundColor=GlobalTableViewBackgroundColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0);
    [self createSubViews];
        
}


-(void) createSubViews
{
    
    //1、tableView
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor=GlobalTableViewBackgroundColor;
    
    //设置contentInset,使表格向下偏移
    _tableView.contentInset=UIEdgeInsetsMake(kProfileHeaderViewHeight, 0, 0, 0);
    [self.view addSubview:_tableView];
    
    //2、profileHeaderView
    CGFloat profileHeaderViewX=0;
    CGFloat profileHeaderViewY=-kProfileHeaderViewHeight;
    CGFloat profileHeaderWidth=_tableView.frame.size.width;
    CGFloat profileHeaderHeight=kProfileHeaderViewHeight;
    
    CGRect  profileHeaderFrame={profileHeaderViewX,profileHeaderViewY,profileHeaderWidth,profileHeaderHeight};
    self.profileHeaderView=[[ProfileHeaderView alloc] init];
    _profileHeaderView.frame=profileHeaderFrame;
    _profileHeaderView.backgroundColor=GlobalTintColor;
    _profileHeaderView.contentMode=UIViewContentModeScaleAspectFill;
    _profileHeaderView.profileHeaderViewDelegate=self;
    //添加手势
    UITapGestureRecognizer * tapGestureRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapProfileHeaderView:)];
    [_profileHeaderView addGestureRecognizer:tapGestureRecognizer];
    [_tableView addSubview:_profileHeaderView];
    
}


-(void) viewWillAppear:(BOOL)animated
{
    Account * account=[Account shareInstance];
    if (account.isLogin&&account.employee)
    {
        [_profileHeaderView.iconImageView sd_setImageWithURL:[NSURL URLWithString:account.employee.imageUrlStr] placeholderImage:[UIImage imageNamed:@"avatar.png"]];
        if(account.employee.name)
        {
           [_profileHeaderView.nameLabel setText:account.employee.name];
        }
        else
        {
           [_profileHeaderView.nameLabel setText:account.employee.phone];
        }
        [EmployeeHttp employeeMoneySuccess:^(NSUInteger money)
        {
           [_profileHeaderView.moneyLabel.subTitleLabel setText:[NSString stringWithFormat:@"￥%ld",money]];
        } fail:nil];
        [EmployeeHttp employeeScoreSuccess:^(NSUInteger score)
         {
            [_profileHeaderView.pointValueLabel.subTitleLabel setText:[NSString stringWithFormat:@"%ld",score]];
        } fail:nil];
    }
    else
    {
        [_profileHeaderView.iconImageView setImage:[UIImage imageNamed:@"avatar.png"]];
        [_profileHeaderView.moneyLabel.subTitleLabel setText:@"￥0"];
        [_profileHeaderView.pointValueLabel.subTitleLabel setText:@"0"];
        [_profileHeaderView.nameLabel setText:@"点击登陆"];
    }
}
#pragma mark - 点击头部
-(void) tapProfileHeaderView:(UITapGestureRecognizer *) tapGestureRecognizer
{
    Account * account=[Account shareInstance];
    if (account.isLogin&&account.employee)
    {
        AccountViewController * accountViewController=[[AccountViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:accountViewController animated:YES];
    }
    else
    {
        LoginNavigationController * loginNavigationController=[[LoginNavigationController alloc] init];
        [self presentViewController:loginNavigationController animated:YES completion:nil];
    }
}

-(void) profileHeaderView:(ProfileHeaderView *)profileHeaderView didSelectedAtIndex:(NSUInteger)index
{
    //我的积分
    if (index==0)
    {
        [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    }
    else if(index==1)
    {//我的金库
        [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    }
}

#pragma mark -表格数据源及代理
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * identifer=@"separatorCell";
    SeparatorCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil)
    {
        cell=[[SeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.textLabel.font=GlobalFont;
    }
    //覆盖数据要完全
    ProfileCellItem * cellItem=_items[indexPath.row];
    cell.imageView.image=[UIImage imageNamed:cellItem.iconName];
    cell.textLabel.text=cellItem.title;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

#pragma mark -点击表格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Account * account=[Account shareInstance];
    if (!account.isLogin)
    {
        LoginNavigationController * loginNavigationController=[[LoginNavigationController alloc] init];
        [self presentViewController:loginNavigationController animated:YES completion:nil];
    }
    else
    {
       ProfileCellItem * cellItem=_items[indexPath.row];
       [tableView deselectRowAtIndexPath:indexPath animated:YES];
       [self.navigationController pushViewController:[[cellItem.willShowViewControllerClass alloc] init] animated:YES];
    }
}


#pragma mark -滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY< -kProfileHeaderViewHeight)
    {
        CGRect frame = _profileHeaderView.frame;
        frame.origin.y = offsetY;
        frame.size.height =  -offsetY;
         _profileHeaderView.frame = frame;
    }
}

- (void)setIsEnterJobCenterViewController:(BOOL)isEnterJobCenterViewController
{
    _isEnterJobCenterViewController=isEnterJobCenterViewController;
    if (_isEnterJobCenterViewController)
    {
        JobCenterViewController * jobCenterViewControler=[[JobCenterViewController alloc] init];
        [self.navigationController pushViewController:jobCenterViewControler animated:NO];
    }
}
@end
