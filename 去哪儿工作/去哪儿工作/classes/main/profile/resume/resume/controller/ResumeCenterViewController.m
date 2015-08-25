//
//  ResumeCenterViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/24/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ResumeCenterViewController.h"
#import "ResumeBasicViewController.h"
#import "ResumeInfoViewController.h"
#import "EducationExperienceViewController.h"
#import "CampusExperienceViewController.h"
#import "PracticeExperienceViewController.h"
#import "TagViewController.h"
#import "EvaluationViewController.h"
#import "ShowViewController.h"
#import "SeparatorCell.h"
#import "ResumeCellItem.h"
#import "EmployeeHttp.h"
#import "Resume.h"
#import "MBProgressHUD.h"


@interface ResumeCenterViewController ()<UINavigationControllerDelegate>
{
    Resume  * _resume;
    NSArray * _items;
}
@end

@implementation ResumeCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"我的简历";
    //设定返回按钮
    self.navigationItem.backBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@""
                                      style:UIBarButtonItemStylePlain
                                      target:nil
                                      action:nil];
    //数据
    ResumeCellItem * infoItem=[[ResumeCellItem alloc] initWithTitle:@"基本信息" willShowViewControllerClass:[ResumeInfoViewController class]];
    ResumeCellItem * educationItem=[[ResumeCellItem alloc] initWithTitle:@"教育经历" willShowViewControllerClass:[EducationExperienceViewController class]];
    ResumeCellItem * schoolItem=[[ResumeCellItem alloc] initWithTitle:@"校内经历" willShowViewControllerClass:[CampusExperienceViewController class]];
    ResumeCellItem * practiceItem=[[ResumeCellItem alloc] initWithTitle:@"实践经历" willShowViewControllerClass:[PracticeExperienceViewController class]];
   
    ResumeCellItem * certificateItem=[[ResumeCellItem alloc] initWithTitle:@"个人标签" willShowViewControllerClass:[TagViewController class]];
    ResumeCellItem * commentItem=[[ResumeCellItem alloc] initWithTitle:@"自我评价" willShowViewControllerClass:[EvaluationViewController class]];
    ResumeCellItem * showItem=[[ResumeCellItem alloc] initWithTitle:@"个人展示" willShowViewControllerClass:[ShowViewController class]];
    _items=@[infoItem,educationItem,schoolItem,practiceItem,certificateItem,commentItem,showItem];
    
    //tableView
    self.tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor=GlobalTableViewBackgroundColor;
    //
    [self requestData];
}

-(void) requestData
{
    //请求数据
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = @"努力加载中";
    [hud show:YES];
    self.tableView.userInteractionEnabled=NO;
    [EmployeeHttp getEmployeeResumeSuccess:^(Resume *resume)
     {
         _resume=resume;
         self.tableView.userInteractionEnabled=YES;
        [hud removeFromSuperview];
     } fail:^
     {
        [hud removeFromSuperview];
     }];
}



-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer=@"cell";
    SeparatorCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil)
    {
        cell=[[SeparatorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font=GlobalFont;
    }
    //覆盖数据要完全
    ResumeCellItem * item=_items[indexPath.row];
    cell.textLabel.text=item.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ResumeCellItem * item=_items[indexPath.row];
    ResumeBasicViewController * resumeBasciViewController=[[item.willShowViewControllerClass alloc] init];
    resumeBasciViewController.resume=_resume;
    [self.navigationController pushViewController:resumeBasciViewController animated:YES];
}

@end
