//
//  InternTableViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/24/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "InternTableViewController.h"
#import "InternDetailViewController.h"
#import "PageCollection.h"
#import "InternCell.h"

@interface InternTableViewController ()

@end

@implementation InternTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.title=@"实习";
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
    return kInterCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer=@"internCell";
    InternCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil)
    {
        cell=[[InternCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    [cell setIntern:self.pageCollection.array[indexPath.row]];
    return cell;
}

#pragma mark -点击表格行

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    InternDetailViewController * internDetailViewController=[[InternDetailViewController alloc] initWithIntern:self.pageCollection.array[indexPath.row]];
    internDetailViewController.companyDetailViewControllerHidden=_companyDetailViewControllerHidden;
    [self.navigationController pushViewController:internDetailViewController animated:YES];
}

@end
