//
//  CompantJobViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/19/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CompanyJobTableViewController.h"
#import "CompanyHttp.h"


@interface CompanyJobTableViewController ()

@end

@implementation CompanyJobTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.companyDetailViewControllerHidden=YES;
}
#pragma mark - 加载数据
-(void) requestData:(PageCollection *)pageCollection
{
    [CompanyHttp getCompanyJobWithId:_companyId oldPageCollection:pageCollection isAppended:YES success:^(PageCollection *newPageCollection)
     {
          self.pageCollection=newPageCollection;
          [self.tableView reloadData];
     } fail:^
     {
         
     }];
}

@end
