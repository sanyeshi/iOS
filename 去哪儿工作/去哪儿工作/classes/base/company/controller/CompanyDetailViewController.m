//
//  CompanyDetailViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/5/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CompanyDetailCell.h"
#import "CompanySimpleCell.h"
#import "CompanyCommentCell.h"
#import "CompanyCommentHeaderView.h"
#import "CompanyDetailViewController.h"
#import "CompanyHttp.h"
#import "Company.h"
#import "CompanyComment.h"
#import "CompanyDetaiCellFrame.h"
#import "PageCollection.h"
#import "MJRefresh.h"
#import "CompanyJobTableViewController.h"
#import "CompanyInternTableViewController.h"
#import "LoginNavigationController.h"
#import "MBProgressHUD.h"
#import "AlertView.h"
#import "EmployeeHttp.h"
#import "Account.h"

#define kPageSize 20

@interface CompanyDetailViewController ()
{
    BOOL      _isFavorite;
    Company * _company;
    CompanyDetailCell     *  _companyDetailCell;
    CompanyDetaiCellFrame * _companyDetailCellFrame;
    PageCollection        * _companyCommentPageCollection;
}
@end

@implementation CompanyDetailViewController

-(instancetype)initWithCompany:(Company *)company
{
    self = [super init];
    if (self)
    {
        _company=company;
        _companyDetailCellFrame=[[CompanyDetaiCellFrame alloc] initWithScreenWidth:[[UIScreen mainScreen] bounds].size.width company:company];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"公司详情";
    self.view.backgroundColor=GlobalTableViewBackgroundColor;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self createRefreshControl];
    //请求数据
    _companyCommentPageCollection=[[PageCollection alloc] init];
    [self requestComments:_companyCommentPageCollection];
    
}

#pragma mark - 添加刷新控件
-(void) createRefreshControl
{
    //下拉刷新
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(pullDownRefresh)];
    [self.tableView.legendHeader setUpdatedTimeHidden:YES];
    self.tableView.header.font =GlobalFont;
    self.tableView.header.textColor =GlobalBlackTextColor;
    
    //上拉刷新
    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(pullUpRefresh)];
    self.tableView.footer.font =GlobalFont;
    self.tableView.footer.textColor =GlobalBlackTextColor;
}

#pragma mark - 上拉刷新
-(void) pullUpRefresh
{
    if (_companyCommentPageCollection.hasNextPage)
    {
        _companyCommentPageCollection.currentPage=_companyCommentPageCollection.nextPage;
        [self requestComments:_companyCommentPageCollection];
    }
    else
    {
        [self.tableView.legendFooter setTitle:@"没有更多数据" forState: MJRefreshFooterStateIdle];
        self.tableView.legendFooter.userInteractionEnabled=NO;
        [self.tableView.legendFooter endRefreshing];
    }
}
#pragma mark - 下拉刷新全部数据
-(void) pullDownRefresh
{
    //防止刷新闪烁
    PageCollection *pageCollection=[[PageCollection alloc] init];
    [self requestComments:pageCollection];
    [self.tableView.legendHeader endRefreshing];
    self.tableView.legendFooter.userInteractionEnabled=YES;
    [self.tableView.legendFooter setTitle:@"点击加载更多数据" forState: MJRefreshFooterStateIdle];
}
#pragma mark - 请求数据

-(void) requestComments:(PageCollection *) pageCollection
{
    
    [CompanyHttp getCompanyCommentWithId:_company.Id oldPageCollection:pageCollection isAppended:YES success:^(PageCollection *newPageCollection)
    {
        _companyCommentPageCollection=newPageCollection;
        [self.tableView.legendFooter endRefreshing];
        [self.tableView reloadData];
    } fail:^
    {
        [self.tableView.legendHeader endRefreshing];
        [self.tableView.legendHeader endRefreshing];
    }];
}

#pragma mark - Table view data source

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{  if(section==0)
   {
      return 3;
   }
    return _companyCommentPageCollection.array.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            return [_companyDetailCellFrame  getCompanyDetailCellHeight];
        }
        return 40.0f;
    }
    else
    {
        return kCommentCellHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            CompanyDetailCell * cell=[[CompanyDetailCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:nil];
            [cell setDetailFrame:_companyDetailCellFrame];
            [cell setCompany:_company];
            _companyDetailCell=cell;
            return cell;
        }
        else if(indexPath.row==1)
        {   
            CompanySimpleCell * cell=[[CompanySimpleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.titleLabel.text=@"公司发布的兼职";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        else
        {
            CompanySimpleCell * cell=[[CompanySimpleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.titleLabel.text=@"公司发布的实习";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
   }
   else
    {
        static NSString * identifer=@"companyCommentCell";
        CompanyCommentCell*cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (cell==nil)
        {
            cell=[[CompanyCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        if (_companyCommentPageCollection.array.count>0)
        {
          [cell setCompanyComment:_companyCommentPageCollection.array[indexPath.row]];
        }
        return cell;
    }
}
#pragma mark -点击表格行
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.row==1)
        {
            //公司发布的兼职
            CompanyJobTableViewController * viewController=[[CompanyJobTableViewController alloc] init];
            [viewController setCompanyId:_company.Id];
            [self.navigationController pushViewController:viewController animated:YES];
        }
        else if(indexPath.row==2)
        {
            //公司发布的实习
            CompanyInternTableViewController * viewController=[[CompanyInternTableViewController alloc] init];
            [viewController setCompanyId:_company.Id];
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
}

#pragma mark -表格头
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1)
    {
        return kCompanyCommentHeaderViewHeight;
    }
    return 0;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1)
    {
        CompanyCommentHeaderView * headerView=[[CompanyCommentHeaderView alloc] init];
        if (_companyCommentPageCollection.array==nil||_companyCommentPageCollection.array.count==0)
        {
            headerView.titleLabel.textColor=GlobalBackgroundTextColor;
            headerView.titleLabel.text=@"暂无评价";
        }
        return headerView;
    }
    return nil;
}

#pragma mark -视图即将出现
-(void) viewWillAppear:(BOOL)animated
{
    Account * account=[Account shareInstance];
    if (account.isLogin)
    {
        //查询是否已关注
        [EmployeeHttp employeeIsFavoriteWithType:@"company" typeId:_company.Id success:^(BOOL isFavorite)
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
            [EmployeeHttp employeeAddFavoriteWithType:@"company" typeId:_company.Id success:^(NSDictionary *dict)
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
        [EmployeeHttp employeeDeleteFavoriteWithType:@"company" typeId:_company.Id success:^(NSDictionary *dict)
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

-(void) viewDidAppear:(BOOL)animated
{
    
}

@end
