//
//  InfoMainViewController.m
//  parttime
//
//  Created by 孙硕磊 on 3/27/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "NewsRootViewController.h"
#import "NewsHeaderView.h"
#import "NewsImageCell.h"
#import "SeparatorCell.h"
#import "UIImageView+WebCache.h"
#import "PageCollection.h"
#import "Http.h"
#import "News.h"
#import "NewsItem.h"
#import "NewDetailViewController.h"

@interface NewsRootViewController ()
{
    
}
@end

@implementation NewsRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight=0;
    self.tableView.sectionFooterHeight=0;
    self.navigationItem.title=@"资讯";
}

#pragma mark -请求数据
-(void) requestData:(PageCollection *)pageCollection
{
    [Http getNews:pageCollection isAppended:YES success:^(PageCollection *newPageCollection)
    {
        self.pageCollection=newPageCollection;
        [self.tableView reloadData];
    } fail:^
    {
        
    }];
}

#pragma mark - 表格数据源及代理
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.pageCollection.array.count;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kNewsImageCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    News * news=self.pageCollection.array[indexPath.section];
    static NSString * Id=@"infoImageCell";
    NewsImageCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (cell==nil)
    {
        cell=[[NewsImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
    }
    [cell.newsImageView sd_setImageWithURL:[NSURL URLWithString:news.imageUrlStr]];
    [cell.newsTitleLabel setText:news.title];
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kNewsHeaderViewHeight;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString * headerViewId=@"newsHeaderView";
    NewsHeaderView * headerView=[tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewId];
    if (headerView==nil)
    {
      headerView=[[NewsHeaderView alloc] initWithReuseIdentifier:headerViewId];
    }
    News * news=self.pageCollection.array[section];
    headerView.dateLabel.text=news.postTime;
    return headerView;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    News * news=self.pageCollection.array[indexPath.section];
    NewDetailViewController * newsDetailViewController=[[NewDetailViewController alloc] init];
    [newsDetailViewController setNews:news];
    [self.navigationController pushViewController:newsDetailViewController animated:YES];
}

@end
