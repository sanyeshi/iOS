//
//  AddSchoolViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/24/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ExperienceEditionViewController.h"
#import "ExperienceViewController.h"

#import "TextFieldCell.h"
#import "TextFieldModel.h"
#import "AlertView.h"
#import "NSString+Validator.h"
#import "NSDate+Format.h"

#import "MBProgressHUD.h"
#import "EmployeeHttp.h"


@interface ExperienceEditionViewController ()
{
    NSMutableArray * _cells;
    
    NSString       * _titleTip;
    NSString       * _detailTip;
    NSString       * _startTimeTip;
    NSString       * _endTimeTip;
    
    NSArray * _tips;
    NSArray * _data;
}
@end

@implementation ExperienceEditionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor=GlobalTableViewBackgroundColor;
    self.tableView.sectionHeaderHeight=0;
    self.tableView.sectionHeaderHeight=0;
    #warning UIBarButtonItem字体大小
    //NSDictionary * attr=[NSDictionary dictionaryWithObjectsAndKeys:GlobalFont,NSFontAttributeName,nil];
    //[leftBarButtonItem setTitleTextAttributes:attr forState:UIControlStateNormal];
    UIBarButtonItem * rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem=rightBarButtonItem;
    //初始化数据
    [self initData];
}

-(void)  initData
{
    _cells=[NSMutableArray array];
    if (_experienceAccessType==ExperienceAccessTypeUpdate)
    {
        Experience * experience=_experiences[_index];
        _data=@[experience.title,experience.detail,experience.startTime,experience.endTime];
    }
}

-(void) setExperienceType:(ExperienceType)experienceType
{
    _experienceType=experienceType;
    if (_experienceType==ExperienceTypeEducation)
    {
        _titleTip=@"学校名称";
        _detailTip=@"所学专业";
        _startTimeTip=@"入学时间";
        _endTimeTip=@"毕业时间";
    }
    else
    {
        _titleTip=@"工作标题";
        _detailTip=@"工作描述";
        _startTimeTip=@"开始时间";
        _endTimeTip=@"结束时间";
    }
    TextFieldModel * schoolModel=[[TextFieldModel alloc] initWithTitle:_titleTip keyboardType:TextFieldKeyBoardTypeDefault];
    TextFieldModel * majorModel=[[TextFieldModel alloc] initWithTitle:_detailTip keyboardType:TextFieldKeyBoardTypeDefault];
    TextFieldModel * startDateModel=[[TextFieldModel alloc] initWithTitle:_startTimeTip keyboardType:TextFieldKeyBoardTypeDate];
    TextFieldModel * endDateModel=[[TextFieldModel alloc] initWithTitle:_endTimeTip keyboardType:TextFieldKeyBoardTypeDate];
    _tips=@[schoolModel,majorModel,startDateModel,endDateModel];
    [self customTitle];
}

-(void) setExperienceAccessType:(ExperienceAccessType)experienceAccessType
{
    _experienceAccessType=experienceAccessType;
    [self customTitle];
}

-(void) customTitle
{
    if (_experienceAccessType==ExperienceAccessTypeUpdate)
    {
        if (_experienceType==ExperienceTypeEducation)
        {
            self.title=@"更新教育经历";
        }
        else if (_experienceType==ExperienceTypeCampus)
        {
            self.title=@"更新校内经历";
        }
        else if (_experienceType==ExperienceTypePractice)
        {
            self.title=@"更新实践经历";
        }
    }
    else
    {
        if (_experienceType==ExperienceTypeEducation)
        {
            self.title=@"添加教育经历";
        }
        else if (_experienceType==ExperienceTypeCampus)
        {
            self.title=@"添加校内经历";
        }
        else if (_experienceType==ExperienceTypePractice)
        {
            self.title=@"添加实践经历";
        }
    }
}

-(void) done:(UIBarButtonItem *) barButtonItem
{
    TextFieldCell * cell=_cells[0];
    NSString * title=cell.textField.text;
    if ([title isEmpty])
    {
        [self showError:[NSString stringWithFormat:@"%@为空",_titleTip]];
        return;
    }
    
    cell=_cells[1];
    NSString * detail=cell.textField.text;
    if([detail isEmpty])
    {
        [self showError:[NSString stringWithFormat:@"%@为空",_detailTip]];
        return;
    }
    
    cell=_cells[2];
    NSString * startTime=cell.textField.text;
    if([startTime isEmpty])
    {
        [self showError:[NSString stringWithFormat:@"%@为空",_startTimeTip]];
        return;
    }
    
    cell=_cells[3];
    NSString * endTime=cell.textField.text;
    if([endTime isEmpty])
    {
        [self showError:[NSString stringWithFormat:@"%@为空",_endTimeTip]];
        return;
    }
    
    NSDate * startDate=[NSDate dateFromString:startTime format:@"yyyy.MM.dd"];
    NSDate * endDate=[NSDate dateFromString:endTime format:@"yyyy.MM.dd"];
    if( [startDate laterDate:endDate ]==startDate)
    {
        [self showError:[NSString stringWithFormat:@"%@晚于%@",_startTimeTip,_endTimeTip]];
        return;
    }
    Experience * experience=[[Experience alloc] init];
    experience.title=title;
    experience.detail=detail;
    experience.startTime=startTime;
    experience.endTime=endTime;
    
    NSMutableArray * array=[NSMutableArray arrayWithArray:_experiences];
    NSString * json=nil;
    if(_experienceAccessType==ExperienceAccessTypeWrite)
    {
       //添加
       [array addObject:experience];
    }
    else
    {
       //更新
       [array replaceObjectAtIndex:_index withObject:experience];
    }
    json=[Experience toJsonWithArray:array];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = @"更新中";
    [hud show:YES];
    [EmployeeHttp updateExperienceWithExperienceType:self.experienceType json:json success:^(BOOL isSucess)
    {
        [hud removeFromSuperview];
        if (isSucess)
        {
            if (_experienceType==ExperienceTypeEducation)
            {
                _parent.resume.educationExperiences=array;
            }
            else if (_experienceType==ExperienceTypeCampus)
            {
                _parent.resume.campusExperiences=array;
            }
            else
            {
                _parent.resume.practiceExperiences=array;
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:^
    {
        [hud removeFromSuperview];
    }];
}

-(void) showError:(NSString * ) title
{
    AlertView * alertView=[[AlertView alloc] init];
    alertView.title=title;
    [alertView show];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tips.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TextFieldCell*cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [_cells addObject:cell];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.leftLabelWidth=80;
    TextFieldModel * textFieldModel=_tips[indexPath.row];
    [cell setTextFieldModel:textFieldModel];
    if (_data)
    {
        cell.textField.text=_data[indexPath.row];
    }
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

@end
