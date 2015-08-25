//
//  CategoryInternViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/24/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CategoryInternTableViewController.h"
#import "InternHttp.h"

@interface CategoryInternTableViewController ()

@end

@implementation CategoryInternTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void) requestData:(PageCollection *)pageCollection
{
    [InternHttp getInternWithCategory:self.category orderBy:self.orderType oldPageCollection:pageCollection isAppended:YES success:^(PageCollection *newPageCollection)
     {
         self.pageCollection=newPageCollection;
         [self.tableView reloadData];
         
     } fail:^
     {
         
     }];
}

@end
