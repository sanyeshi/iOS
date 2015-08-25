//
//  JobTableViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/18/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "JobTableViewController.h"
#import "JobDetailViewController.h"
#import "JobCell.h"
#import "PageCollection.h"
#import "Application.h"
#import "Job.h"


@interface JobTableViewController ()
{
    
}
@end

@implementation JobTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"兼职";
    self.orderType=@"newest";
}

#pragma mark - 请求数据
-(void) requestData:(PageCollection *)pageCollection
{
    
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pageCollection.array.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kJobCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer=@"jobCell";
    JobCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil)
    {
        cell=[[JobCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    if ([self.pageCollection.array[indexPath.row] isMemberOfClass:[Application class]])
    {
        Application * application=self.pageCollection.array[indexPath.row];
        [cell setJob:application.job];
    }
    else
    {
       [cell setJob:self.pageCollection.array[indexPath.row]];
    }
    return cell;
}

#pragma mark -点击表格行

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JobDetailViewController * jobDetailViewController=[[JobDetailViewController alloc] initWithJob:self.pageCollection.array[indexPath.row]];
    jobDetailViewController.companyDetailViewControllerHidden=_companyDetailViewControllerHidden;
    [self.navigationController pushViewController:jobDetailViewController animated:YES];
}

@end
