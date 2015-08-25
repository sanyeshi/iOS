//
//  MyFavoriteViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/20/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "MyFavoriteTableViewController.h"
#import "PageCollection.h"
#import "JobCell.h"
#import "JobDetailViewController.h"
#import "InternCell.h"
#import "InternDetailViewController.h"
#import "CompanyCell.h"
#import "CompanyDetailViewController.h"
#import "EmployeeHttp.h"

@interface MyFavoriteTableViewController ()
{
    PageCollection * _jobPageCollection;
    PageCollection * _internPageCollection;
    PageCollection * _companyPageCollection;
}
@end

@implementation MyFavoriteTableViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _jobPageCollection=[[PageCollection alloc] init];
        _internPageCollection=[[PageCollection alloc] init];
        _companyPageCollection=[[PageCollection alloc] init];
    }
    return self;
}

#pragma mark - 请求数据
-(void) requestData:(PageCollection *)pageCollection
{
    [EmployeeHttp getEmployeeFavoriteWithType:_myFavoriteType oldPageCollection:pageCollection isAppended:YES success:^(PageCollection *newPageCollection)
    {
        self.pageCollection=newPageCollection;
        if (_myFavoriteType==MyFavoriteTypeParttimeJob)
        {
            _jobPageCollection=newPageCollection;
        }
        else if(_myFavoriteType==MyFavoriteIntern)
        {
            _internPageCollection=newPageCollection;
        }
        else
        {
            _companyPageCollection=newPageCollection;
        }
        [self.tableView reloadData];
    } fail:^
    {
        
    }];
}

-(void) reloadData
{
   [self beginHeaderRefreshing];
}

#warning 性能提升
#pragma mark - 头部刷新全部数据
-(void) didHeaderRefresh
{
     PageCollection *pageCollection=nil;
    _jobPageCollection=[[PageCollection alloc] init];
    _internPageCollection=[[PageCollection alloc] init];
    _companyPageCollection=[[PageCollection alloc] init];
    if (_myFavoriteType==MyFavoriteTypeParttimeJob)
    {
        pageCollection=_jobPageCollection;
    }
    else if(_myFavoriteType==MyFavoriteIntern)
    {
        pageCollection=_internPageCollection;
    }
    else
    {
        pageCollection=_companyPageCollection;
    }
    [self requestData:pageCollection];
    [NSThread sleepForTimeInterval:0.2];
    [self endHeaderRefreshing];
    [self setFooterEnabled:YES];
    [self setFooterTitle:@"加载更多数据" forState: FooterRefreshStateIdle];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pageCollection.array.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_myFavoriteType==MyFavoriteTypeParttimeJob)
    {
        return kJobCellHeight;
    }
    else if(_myFavoriteType==MyFavoriteIntern)
    {
        return kInterCellHeight;
    }
    else
    {
        return kCompanyCellHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_myFavoriteType==MyFavoriteTypeParttimeJob)
    {
        static NSString * jobCellId=@"jobCell";
        JobCell *cell = [tableView dequeueReusableCellWithIdentifier:jobCellId];
        if (cell==nil)
        {
            cell=[[JobCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:jobCellId];
        }
        [cell setJob:self.pageCollection.array[indexPath.row]];
        return cell;
    }
    else if(_myFavoriteType==MyFavoriteIntern)
    {
        
        static NSString * internCellId=@"internCell";
        InternCell *cell = [tableView dequeueReusableCellWithIdentifier:internCellId];
        if (cell==nil)
        {
            cell=[[InternCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:internCellId];
        }
         [cell setIntern:self.pageCollection.array[indexPath.row]];
        return cell;

    }
    else
    {
        static NSString * companyCellId=@"companyCell";
        CompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:companyCellId];
        if (cell==nil)
        {
            cell=[[CompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:companyCellId];
        }
        [cell setCompany:self.pageCollection.array[indexPath.row]];
        return cell;
    }

}

#pragma mark -点击表格行

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_myFavoriteType==MyFavoriteTypeParttimeJob)
    {
        JobDetailViewController * jobDetailViewController=[[JobDetailViewController alloc] initWithJob:self.pageCollection.array[indexPath.row]];
        [self.navigationController pushViewController:jobDetailViewController animated:YES];
    }
    else if(_myFavoriteType==MyFavoriteIntern)
    {
        InternDetailViewController * internDetailViewController=[[InternDetailViewController alloc] initWithIntern:self.pageCollection.array[indexPath.row]];
        [self.navigationController pushViewController:internDetailViewController animated:YES];
    }
    else
    {
        CompanyDetailViewController * companyDetailViewController=[[CompanyDetailViewController alloc] initWithCompany:self.pageCollection.array[indexPath.row]];
        [self.navigationController pushViewController:companyDetailViewController animated:YES];
    }
}

-(void) viewDidAppear:(BOOL)animated
{
    
}

@end
