//
//  HomeContentViewController.m
//  去哪儿工作
//
//  Created by 孙硕磊 on 5/9/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "HomeContentViewController.h"
#import "HomeHeaderCell.h"
#import "HomeContentCell.h"
#import "JobCell.h"
#import "InternDetailViewController.h"
#import "JobDetailViewController.h"
#import "CompanyDetailViewController.h"
#import "Http.h"
#import "PageCollection.h"
#import "HomeContent.h"
#import "HomeHeaderBanner.h"

#import "SSLViwepager.h"

@interface HomeContentViewController ()<HomeHeaderCellDelegate>
{
    NSArray         * _headerBannerArray;
    PageCollection  * _homeContentPageCollection;
}
@end

@implementation HomeContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //请求数据
    [self beginHeaderRefreshing];
}
#pragma mark -底部刷新
-(void) didFooterRefresh
{
    if (_homeContentPageCollection.hasNextPage)
    {
        _homeContentPageCollection.currentPage=_homeContentPageCollection.nextPage;
        [self requestData:_homeContentPageCollection];
    }
    else
    {
        [self setFooterEnabled:NO];
        [self setFooterTitle:@"没有更多数据" forState:FooterRefreshStateIdle];
        [self endFooterRefreshing];
    }
}
#pragma mark - 头部整个刷新
-(void) didHeaderRefresh
{
    [NSThread sleepForTimeInterval:0.2];
    [self loadData];
    [self setFooterEnabled:YES];
    [self setFooterTitle:@"点击加载更多数据" forState:FooterRefreshStateIdle];

}

#pragma mark -- 请求数据
-(void) loadData
{
    //请求banner数据
    [Http getHomeHeaderBanner:^(NSArray *models)
     {
         _headerBannerArray=models;
         [self.tableView reloadSections:[[NSIndexSet alloc]initWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
     }fail:^
     {
         [self endRefreshing];
     }];
    //防止表格刷新闪烁
    PageCollection *  pageCollection=[[PageCollection alloc] init];
    [self requestData:pageCollection];
}

#pragma mark -网络请求数据
-(void) requestData:(PageCollection *) pageCollection
{
    [Http getHomeContent:pageCollection isAppended:YES success:^(PageCollection *newPageCollection)
     {
         _homeContentPageCollection=newPageCollection;
         [self endRefreshing];
         [self.tableView reloadData];
     } fail:^
     {
         [self endRefreshing];
     }];
}

#pragma mark -表格数据源及代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else
    {
        if (_homeContentPageCollection)
        {
            return _homeContentPageCollection.array.count;
        }
        return 0;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        return kHomeHeaderCellHeight;
    }
    return kHomeContentCellHeight;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        HomeHeaderCell * homeHederCell=[[HomeHeaderCell alloc] initWithModels:_headerBannerArray];
        homeHederCell.homeHeaderCellDelegate=self;
        return homeHederCell;
    }
    else
    {
        static NSString * identifer=@"homeContentCell";
        HomeContentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (cell==nil)
        {
            cell=[[HomeContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        //覆盖数据要完全
        cell.model=_homeContentPageCollection.array[indexPath.row];
        return cell;
    }
}

#pragma mark --点击表格
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section>0)
    {
        // 去除选中时的背景
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        HomeContent * content=_homeContentPageCollection.array[indexPath.row];
        UIViewController * willShowViewController=nil;
        if (content.type==HomeContentCellTypeIntern)
        {
            willShowViewController=[[InternDetailViewController alloc] initWithInternId:content.fId];
        }
        else if(content.type==HomeContentCellTypeJob)
        {
            willShowViewController=[[JobDetailViewController alloc] initWithJobId:content.fId];
        }
        else if(content.type==HomeContentCellTypeCompany)
        {
            CompanyDetailViewController * compantDetailViewController=[[CompanyDetailViewController alloc] initWithCompany:content.company];
            willShowViewController=compantDetailViewController;
        }
        [self.navigationController pushViewController:willShowViewController animated:YES];
    }
}

#pragma mark -点击表格头
-(void)homeHeaderCell:(HomeHeaderCell *)homeHeaderCell didSelectAtIndex:(NSInteger)index
{
    if (index<_headerBannerArray.count)
    {
        HomeHeaderBanner * model=_headerBannerArray[index];
        NSInteger jobId=model.jobId;
        JobDetailViewController * jobDetailViewController=[[JobDetailViewController alloc] initWithJobId:jobId];
        [self.navigationController pushViewController:jobDetailViewController animated:YES];
    }
}
@end
