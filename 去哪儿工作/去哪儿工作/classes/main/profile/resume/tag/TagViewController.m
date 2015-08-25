//
//  TagViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/25/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "TagViewController.h"
#import "SeparatorCell.h"
#import "TagEditionViewController.h"

#import "EmployeeHttp.h"
#import "MBProgressHUD.h"

@interface TagViewController ()<UITableViewDataSource,UITableViewDelegate>
{
       
    UITableView *  _tableView;
    NSArray     *  _tags;
    NSInteger      _deletedIndex;
}
@end

@implementation TagViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"个人标签";
    self.view.backgroundColor=[UIColor whiteColor];
    //
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addTag:)];
   
    //表格
    _tableView=[[UITableView alloc] initWithFrame:self.view.frame];
    _tableView.backgroundColor=GlobalTableViewBackgroundColor;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
    //初始化数据
    _tags=self.resume.tags;
}


-(void) viewWillAppear:(BOOL)animated
{
    _tags=self.resume.tags;
    [_tableView reloadData];
}

#pragma mark -添加tag
-(void) addTag:(UIBarButtonItem *) barButtonItem
{
    TagEditionViewController * tagEditionViewController=[[TagEditionViewController alloc] initWithStyle:UITableViewStyleGrouped];
    tagEditionViewController.parent=self;
    tagEditionViewController.tagAccessType=TagAccessTypeWrite;
    [self.navigationController pushViewController:tagEditionViewController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer=@"cell";
    SeparatorCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil)
    {
        cell=[[SeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.textLabel.font=GlobalFont;
    }
    cell.textLabel.text=_tags[indexPath.row];
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TagEditionViewController * tagEditionViewController=[[TagEditionViewController alloc] initWithStyle:UITableViewStyleGrouped];
    tagEditionViewController.parent=self;
    tagEditionViewController.index=indexPath.row;
    tagEditionViewController.tagAccessType=TagAccessTypeUpdate;
    [self.navigationController pushViewController:tagEditionViewController animated:YES];
}

#pragma mark - 编辑表格
-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete)
    {
        _deletedIndex=indexPath.row;
        UIAlertView * alertView=[[UIAlertView alloc] initWithTitle:@"" message:@"删除此项经历" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        [alertView show];
    }
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //确定删除
    if (buttonIndex==1)
    {
        NSMutableArray * array=[NSMutableArray arrayWithArray:_tags];
        [array removeObjectAtIndex:_deletedIndex];
        NSString * tags=[self tagsWithArray:array];
        
        
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hud];
        hud.labelText = @"删除中";
        [hud show:YES];
        [EmployeeHttp updateTagsWithTags:tags success:^(BOOL isSuccess)
         {
             [hud removeFromSuperview];
             if (isSuccess)
             {
                 self.resume.tags=array;
                 _tags=array;
                 [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_deletedIndex inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
             }
             
         } fail:^{
             
             [hud removeFromSuperview];
         }];

        
    }
    else
    {
        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_deletedIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(NSString *) tagsWithArray:(NSArray *) array
{
    NSMutableString * tags=[NSMutableString string];
    NSInteger count=array.count;
    for (int i=0; i<count; i++)
    {
        [tags appendString:array[i]];
        if (i+1!=count)
        {
            [tags appendString:@";"];
        }
    }
    return [tags copy];
}

@end
