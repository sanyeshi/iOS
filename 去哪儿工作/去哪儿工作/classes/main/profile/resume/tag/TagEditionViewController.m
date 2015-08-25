//
//  TagEditionViewController.m
//  parttime
//
//  Created by 孙硕磊 on 5/18/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "TagEditionViewController.h"

#import "TagViewController.h"
#import "TextFieldModel.h"
#import "TextFieldCell.h"

#import "NSString+Validator.h"
#import "AlertView.h"
#import "MBProgressHUD.h"
#import "EmployeeHttp.h"

@interface TagEditionViewController ()
{
    TextFieldModel * _tagModel;
    TextFieldCell  * _cell;
    NSString       * _tag;
}
@end

@implementation TagEditionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor=GlobalTableViewBackgroundColor;
    self.navigationItem.rightBarButtonItem=  [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
    
    if (_tagAccessType==TagAccessTypeWrite)
    {
        self.title=@"添加标签";
    }
    else
    {
        self.title=@"更新标签";
        _tag=_parent.resume.tags[_index];
    }
    _tagModel=[[TextFieldModel alloc] initWithTitle:@"个人标签" keyboardType:TextFieldKeyBoardTypeDefault];
    
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TextFieldCell*cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    _cell=cell;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.leftLabelWidth=80;
    [cell setTextFieldModel:_tagModel];
    if (_tag)
    {
        cell.textField.text=_tag;
    }
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}


-(void) done:(UIBarButtonItem *) barButtonItem
{
    [_cell.textField resignFirstResponder];
    NSString * tag=_cell.textField.text;
    if ([tag isEmpty])
    {
        AlertView * alertView=[[AlertView alloc] init];
        alertView.title=@"个人标签为空";
        [alertView show];
        return;
    }
    
    NSMutableArray * array=[NSMutableArray arrayWithArray:_parent.resume.tags];
    if(_tagAccessType==TagAccessTypeWrite)
    {
        //添加
        [array addObject:tag];
    }
    else
    {
        //更新
        [array replaceObjectAtIndex:_index withObject:tag];
    }
    NSString * tags=[self tagsWithArray:array];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = @"更新中";
    [hud show:YES];
    [EmployeeHttp updateTagsWithTags:tags success:^(BOOL isSuccess)
    {
        [hud removeFromSuperview];
        if (isSuccess)
        {
            _parent.resume.tags=array;
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } fail:^{
       
        [hud removeFromSuperview];
    }];
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
