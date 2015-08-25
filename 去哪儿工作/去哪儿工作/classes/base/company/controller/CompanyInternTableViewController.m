//
//  CompanyInterbViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/24/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CompanyInternTableViewController.h"
#import "CompanyHttp.h"

@interface CompanyInternTableViewController ()

@end

@implementation CompanyInternTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.companyDetailViewControllerHidden=YES;
}
#pragma mark - 加载数据
-(void) requestData:(PageCollection *)pageCollection
{
    [CompanyHttp getCompanyInternWithId:_companyId oldPageCollection:pageCollection isAppended:YES success:^(PageCollection *newPageCollection)
     {
         self.pageCollection=newPageCollection;
         [self.tableView reloadData];
     } fail:^
     {
         
     }];
}

@end
