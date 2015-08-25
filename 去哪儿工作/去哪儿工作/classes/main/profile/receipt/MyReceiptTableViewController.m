//
//  MyReceiptViewController.m
//  parttime
//
//  Created by 孙硕磊 on 5/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "MyReceiptTableViewController.h"
#import "ReceiptCell.h"
#import "EmployeeHttp.h"
#import "PageCollection.h"

@interface MyReceiptTableViewController ()

@end

@implementation MyReceiptTableViewController


#pragma mark - 请求数据
-(void) requestData:(PageCollection *)pageCollection
{
    [EmployeeHttp getEmployeePaymentWithType:_type oldPageCollection:pageCollection isAppended:YES success:^(PageCollection *newPageCollection)
    {
        self.pageCollection=newPageCollection;
        [self.tableView reloadData];

    } fail:^
    {
        
    }];
}

-(void) reloadData
{
    [self beginHeaderRefreshing];
}

#pragma mark -表格数据源及代理

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pageCollection.array.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kReceiptCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer=@"ReceiptCell";
    ReceiptCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil)
    {
        cell=[[ReceiptCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    //覆盖数据要完全
    [cell setReceipt:self.pageCollection.array[indexPath.row]];
    return cell;
}

@end
