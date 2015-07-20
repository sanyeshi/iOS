//
//  RootViewController.m
//  quartz2D
//
//  Created by 孙硕磊 on 7/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "RootViewController.h"
#import "LineViewController.h"
#import "ShapeViewController.h"
#import "TextViewController.h"
#import "ImageViewController.h"
#import "WatermarkViewController.h"
#import "BackgroundViewController.h"

#import "CellItem.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray * _items;
}
@end

@implementation RootViewController


-(void) loadView
{
    UITableView * tableView=[[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate=self;
    tableView.dataSource=self;
    self.view=tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Quartz2D";
    //数据
    CellItem * lineItem=[CellItem cellItemWithTitle:@"画线" class:[LineViewController class]];
    CellItem * shapeItem=[CellItem cellItemWithTitle:@"图形" class:[ShapeViewController class]];
    CellItem * textItem=[CellItem cellItemWithTitle:@"文字" class:[TextViewController class]];
    CellItem * imageItem=[CellItem cellItemWithTitle:@"图片" class:[ImageViewController class]];
    CellItem * watermaskItem=[CellItem cellItemWithTitle:@"水印" class:[WatermarkViewController class]];
    CellItem * backgroundItem=[CellItem cellItemWithTitle:@"背景" class:[BackgroundViewController class]];
    
    _items=@[lineItem,shapeItem,textItem,imageItem,watermaskItem,backgroundItem];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer=@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    //覆盖数据要完全
    CellItem * cellItem=_items[indexPath.row];
    cell.textLabel.text=cellItem.title;
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     CellItem * cellItem=_items[indexPath.row];
     UIViewController * controller=[[cellItem.showClass alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    
}
@end
