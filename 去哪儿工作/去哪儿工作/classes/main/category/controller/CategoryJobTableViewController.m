//
//  CategoryJobViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/19/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CategoryJobTableViewController.h"
#import "JobHttp.h"

@interface CategoryJobTableViewController ()

@end

@implementation CategoryJobTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark -加载数据
-(void) requestData:(PageCollection *)pageCollection
{
    [JobHttp getJobWithCategory:self.category orderBy:self.orderType oldPageCollection:pageCollection isAppended:YES success:^(PageCollection *newPageCollection)
     {
         self.pageCollection=newPageCollection;
         [self.tableView reloadData];
         
     } fail:^
     {
         
     }];
   
}
@end
