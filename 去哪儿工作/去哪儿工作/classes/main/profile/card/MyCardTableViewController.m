//
//  MyCardViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/20/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "MyCardTableViewController.h"
#import "PageCollection.h"
#import "CardCell.h"
#import "EmployeeHttp.h"


@interface MyCardTableViewController ()<CardCellDelegate>
{
}
@end

@implementation MyCardTableViewController


#pragma mark - 请求数据
-(void) requestData:(PageCollection *)pageCollection
{
    [EmployeeHttp getEmployeeCardWithType:_myCardType oldPageCollection:pageCollection isAppended:YES success:^(PageCollection *newPageCollection)
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

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pageCollection.array.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCardCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifer=@"cardCell";
    CardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil)
    {
        cell=[[CardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.delegate=self;
    }
    cell.index=indexPath.row;
    [cell setCard:self.pageCollection.array[indexPath.row]];
    return cell;
}

#pragma mark -点击表格行
-(void) cardCell:(CardCell *)cardCell didPunchCardAtIndex:(NSInteger)index
{
    Log(@"%ld",index);
}

-(void) viewDidAppear:(BOOL)animated
{
    
}

@end
