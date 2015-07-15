//
//  MainViewController.m
//  WebView
//
//  Created by 孙硕磊 on 7/14/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "MainViewController.h"
#import "WebViewController.h"
#import "CellItem.h"


@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,weak) UITableView * tableView;
@property(nonatomic,strong) NSArray   * cellItems;
@end
@implementation MainViewController


-(void) loadView
{
    UITableView * tableView=[[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.dataSource=self;
    tableView.delegate=self;
    self.view=tableView;
    self.tableView=tableView;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    self.title=@"WebView";
    
    NSBundle * mainBundle=[NSBundle mainBundle];
    CellItem * textCellItem=[CellItem cellItemWithTitle:@"Text" url:[mainBundle URLForResource:@"关于" withExtension:@"txt" ]];
    CellItem * pdfCellItem=[CellItem cellItemWithTitle:@"PDF" url:[mainBundle URLForResource:@"iOS6Cookbook" withExtension:@"pdf"]];
    CellItem * docCellItem=[CellItem cellItemWithTitle:@"Doc" url:[mainBundle URLForResource:@"关于" withExtension:@"docx"]];
    CellItem * htmlCellItem=[CellItem cellItemWithTitle:@"HTML" url:[mainBundle URLForResource:@"demo" withExtension:@"html"]];
    
    self.cellItems=@[textCellItem,pdfCellItem,docCellItem,htmlCellItem];
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer=@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    //覆盖数据要完全
    CellItem * cellItem=self.cellItems[indexPath.row];
    cell.textLabel.text=cellItem.title;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     CellItem * cellItem=self.cellItems[indexPath.row];
    WebViewController * webViewController=[[WebViewController alloc]init];
    webViewController.cellItem=cellItem;
    [self.navigationController pushViewController:webViewController animated:YES];
}


@end
