//
//  SchoolViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/24/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ExperienceViewController.h"
#import "Experience.h"
#import "ExperienceCell.h"
#import "ExperienceEditionViewController.h"
#import "NavigationController.h"

#import "EmployeeHttp.h"
#import "MBProgressHUD.h"


@interface ExperienceViewController ()<UIAlertViewDelegate>
{
    UITableView * _tableView;
    NSInteger     _deletedIndex;
}
@end

@implementation ExperienceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=GlobalBackgroundColor;
    //
    self.navigationItem.backBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@""
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:nil
                                                                           action:nil];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addExperience:)];
    //表格
    _tableView=[[UITableView alloc] initWithFrame:self.view.frame];
    _tableView.backgroundColor=GlobalTableViewBackgroundColor;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
}

-(void) viewWillAppear:(BOOL)animated
{
    [_tableView reloadData];
}
-(void) addExperience:(UIBarButtonItem *)barButtonItem
{
    ExperienceEditionViewController * experienceEditionViewController=[[ExperienceEditionViewController alloc] initWithStyle:UITableViewStyleGrouped];
    experienceEditionViewController.parent=self;
    experienceEditionViewController.experienceType=self.experienceType;
    experienceEditionViewController.experienceAccessType=ExperienceAccessTypeWrite;
    experienceEditionViewController.experiences=[self getExperiences];
    [self.navigationController pushViewController:experienceEditionViewController animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self getCellCount];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kExperienceCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer=@"cell";
    ExperiencelCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil)
    {
        cell=[[ExperiencelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    [cell setExperience:[self getExperience:indexPath.row]];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ExperienceEditionViewController * experienceEditionViewController=[[ExperienceEditionViewController alloc] initWithStyle:UITableViewStyleGrouped];
    experienceEditionViewController.parent=self;
    experienceEditionViewController.experienceAccessType=ExperienceAccessTypeUpdate;
    experienceEditionViewController.experienceType=self.experienceType;
    experienceEditionViewController.index=indexPath.row;
    experienceEditionViewController.experiences=[self getExperiences];
    [self.navigationController pushViewController:experienceEditionViewController animated:YES];
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
     
        NSMutableArray * array=[NSMutableArray arrayWithArray:[self getExperiences]];
        [array removeObjectAtIndex:_deletedIndex];
        NSString * json=[Experience toJsonWithArray:array];
        
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:hud];
        hud.labelText = @"删除中";
        [hud show:YES];
        [EmployeeHttp updateExperienceWithExperienceType:self.experienceType json:json success:^(BOOL isSucess)
         {
             [hud removeFromSuperview];
             if (isSucess)
             {
                 if (_experienceType==ExperienceTypeEducation)
                 {
                     
                     self.resume.educationExperiences=array;
                 }
                 else if (_experienceType==ExperienceTypeCampus)
                 {
                     self.resume.campusExperiences=array;
                 }
                 else
                 {
                     self.resume.practiceExperiences=array;
                 }
                 [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_deletedIndex inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
             }
         } fail:^
         {
             [hud removeFromSuperview];
         }];
    }
    else
    {
        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_deletedIndex inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(NSInteger) getCellCount
{
    if (_experienceType==ExperienceTypeCampus)
    {
        return self.resume.campusExperiences.count;
    }
    else if (_experienceType==ExperienceTypeEducation)
    {
        return self.resume.educationExperiences.count;
    }
    else
    {
        return self.resume.practiceExperiences.count;
    }
}

-(Experience *) getExperience:(NSInteger) index
{
    Experience * experience=nil;
    if (_experienceType==ExperienceTypeCampus)
    {
        experience=self.resume.campusExperiences[index];
    }
    else if (_experienceType==ExperienceTypeEducation)
    {
        experience=self.resume.educationExperiences[index];
    }
    else
    {
        experience=self.resume.practiceExperiences[index];
    }

    return experience;
}


-(NSArray *) getExperiences
{
    if (_experienceType==ExperienceTypeCampus)
    {
        return self.resume.campusExperiences;
    }
    else if (_experienceType==ExperienceTypeEducation)
    {
        return self.resume.educationExperiences;
    }
    else
    {
        return self.resume.practiceExperiences;
    }
    
}
@end
