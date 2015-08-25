
//
//  CompanyTableViewController.m
//  parttime
//
//  Created by 孙硕磊 on 5/4/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CompanyTableViewController.h"
#import "PageCollection.h"
#import "CompanyCell.h"
#import "CompanyDetailViewController.h"
#import "CompanyHttp.h"

@interface CompanyTableViewController ()

@end

@implementation CompanyTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"名企招聘";
}

#pragma mark - 请求数据
-(void) requestData:(PageCollection *)pageCollection
{
   
    [CompanyHttp getCompany:pageCollection isAppended:YES success:^(PageCollection *newPageCollection)
    {
        self.pageCollection=newPageCollection;
        [self.tableView reloadData];
    } fail:^
    {
        
    }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pageCollection.array.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCompanyCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer=@"companyCell";
    CompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil)
    {
        cell=[[CompanyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    [cell setCompany:self.pageCollection.array[indexPath.row]];
    return cell;
}

#pragma mark -点击表格行

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CompanyDetailViewController * companyDetailViewController=[[CompanyDetailViewController alloc] initWithCompany:self.pageCollection.array[indexPath.row]];
    [self.navigationController pushViewController:companyDetailViewController animated:YES];
}

@end
