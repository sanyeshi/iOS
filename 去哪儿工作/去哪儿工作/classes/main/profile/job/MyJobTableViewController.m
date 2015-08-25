//
//  MyJobViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/20/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "MyJobTableViewController.h"
#import "MyJobDetailViewController.h"
#import "PageCollection.h"
#import "EmployeeHttp.h"

@interface MyJobTableViewController ()

@end

@implementation MyJobTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - 加载数据
-(void) requestData:(PageCollection *)pageCollection
{
    NSString * jobType=@"apply";
    if (_myJobType==MyJobTypeAccept)
    {
        jobType=@"accept";
    }
    else if (_myJobType==MyJobTypeReject)
    {
        jobType=@"reject";
    }
    else
    {
        jobType=@"apply";
    }
    [EmployeeHttp getEmployeeJobWithType:jobType oldPageCollection:pageCollection isAppended:YES success:^(PageCollection *newPageCollection)
     {
        self.pageCollection=newPageCollection;
        [self.tableView reloadData];
    }
    fail:^
    {
        
    }];
}
-(void) reloadData
{
    [self beginHeaderRefreshing];
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyJobDetailViewController * jobDetailViewController=[[MyJobDetailViewController alloc] init];
    jobDetailViewController.application=self.pageCollection.array[indexPath.row];
    [self.navigationController pushViewController:jobDetailViewController animated:YES];
}

@end
