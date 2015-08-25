//
//  ResumeInfoViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/24/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ResumeInfoViewController.h"
#import "ResumeCellItem.h"
#import "TextFieldModel.h"
#import "TextFieldCell.h"
#import "Employee.h"
#import "EmployeeHttp.h"

#import "MBProgressHUD.h"
#import "AlertView.h"
#import "NSString+Validator.h"

#import "Account.h"
#import "Employee.h"

#define kHeaderViewHeight 20.0f

@interface ResumeInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    
    NSArray* _group;
    NSMutableArray * _cells;
    CGPoint          _originalOffset;
    UITableView    * _tableView;
    NSInteger        _selectedCellIndex;
}
@end

@implementation ResumeInfoViewController

-(void) loadView
{
    _tableView=[[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.backgroundColor=GlobalTableViewBackgroundColor;
    _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableView.sectionFooterHeight=0;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    self.view=_tableView;
    
     _originalOffset=CGPointMake(0, -64);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"基本资料";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(submit:)];
    
    //数据
    TextFieldModel * nameModel=[[TextFieldModel alloc] initWithTitle:@"姓名" content:self.resume.employee.name keyboardType:TextFieldKeyBoardTypeDefault];
    TextFieldModel * ageModel=[[TextFieldModel alloc] initWithTitle:@"年龄"  content:[NSString stringWithFormat:@"%lu",self.resume.employee.age] keyboardType:TextFieldKeyBoardTypeAge];
    TextFieldModel * genderModel=[[TextFieldModel alloc] initWithTitle:@"性别"  content:self.resume.employee.gender
                                                          keyboardType:TextFieldKeyBoardTypeGender];
    TextFieldModel * phoneModel=[[TextFieldModel alloc] initWithTitle:@"手机" content:self.resume.employee.phone
                                                         keyboardType:TextFieldKeyBoardTypePhone];
    phoneModel.isEditable=NO;
    TextFieldModel * emailModel=[[TextFieldModel alloc] initWithTitle:@"邮箱" content:self.resume.employee.email keyboardType:TextFieldKeyBoardTypeEmail];
    NSArray * baseInfoGroup=@[nameModel,ageModel,genderModel,phoneModel,emailModel];
    
    TextFieldModel * schoolModel=[[TextFieldModel alloc] initWithTitle:@"学校"  content:self.resume.employee.school keyboardType:TextFieldKeyBoardTypeDefault];
    TextFieldModel * majorModel=[[TextFieldModel alloc] initWithTitle:@"专业"   content:self.resume.employee.major keyboardType:TextFieldKeyBoardTypeDefault];
    TextFieldModel * gradeModel=[[TextFieldModel alloc] initWithTitle:@"年级" content:self.resume.employee.grade
                                                         keyboardType:TextFieldKeyBoardTypeDefault];
    NSArray * schoolInfoGroup=@[schoolModel,majorModel,gradeModel];
    
    _group=@[baseInfoGroup,schoolInfoGroup];
    _cells=[NSMutableArray array];
}

#pragma mark-保存
-(void) submit:(UIBarButtonItem *) barButtonItem
{
    TextFieldCell * cell=_cells[0];
    NSString * name=cell.textField.text;
    if ([name isEmpty])
    {
        AlertView * alertView=[[AlertView alloc] init];
        alertView.title=@"姓名为空";
        [alertView show];
        return;
    }
    
    cell=_cells[1];
    NSString * age=cell.textField.text;
    
    cell=_cells[2];
    NSInteger gender=[Employee parseGenderToCodeFromString:cell.textField.text];
    
    cell=_cells[4];
    NSString * email=cell.textField.text;
    if (![email isEmailAddress])
    {
        AlertView * alertView=[[AlertView alloc] init];
        alertView.title=@"邮箱格式错误";
        [alertView show];
        return;
    }

    
    cell=_cells[5];
    NSString *school=cell.textField.text;
    if ([school isEmpty])
    {
        AlertView * alertView=[[AlertView alloc] init];
        alertView.title=@"学校为空";
        [alertView show];
        return;
    }

    
    cell=_cells[6];
    NSString * major=cell.textField.text;
    if ([major isEmpty])
    {
        AlertView * alertView=[[AlertView alloc] init];
        alertView.title=@"专业为空";
        [alertView show];
        return;
    }

    
    cell=_cells[7];
    NSString * grade=cell.textField.text;
    if ([grade isEmpty])
    {
        AlertView * alertView=[[AlertView alloc] init];
        alertView.title=@"年级为空";
        [alertView show];
        return;
    }

    
    NSDictionary * paras=@{@"name":name,
                           @"age":age,
                           @"sex":[NSNumber numberWithInteger:gender],
                           @"email":email,
                           @"school":school,
                           @"mayjor":major,
                           @"grade":grade
                           };
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = @"更新中";
    [hud show:YES];
    
    [EmployeeHttp updateEmployeeWithParas:paras success:^(Employee *employee)
    {
        [hud removeFromSuperview];
        if (employee)
        {
            Account * account=[Account shareInstance];
            account.employee.name=employee.name;
            account.employee.age=employee.age;
            account.employee.gender=employee.gender;
            account.employee.email=employee.email;
            account.employee.school=employee.school;
            account.employee.major=employee.major;
            account.employee.grade=employee.grade;
            [account update];
            
            self.resume.employee.name=employee.name;
            self.resume.employee.age=employee.age;
            self.resume.employee.gender=employee.gender;
            self.resume.employee.email=employee.email;
            self.resume.employee.school=employee.school;
            self.resume.employee.major=employee.major;
            self.resume.employee.grade=employee.grade;
        }
        
    } fail:^
    {
        [hud removeFromSuperview];
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _group.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * group=_group[section];
    return group.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    TextFieldCell*cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [_cells addObject:cell];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textField.delegate=self;
    if (indexPath.section==1)
    {
        cell.tag=indexPath.row+[_group[0] count];
    }
    else
    {
        cell.tag=indexPath.row;
    }
    NSArray * group=_group[indexPath.section];
    TextFieldModel * textFieldModel=group[indexPath.row];
    [cell setTextFieldModel:textFieldModel];
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kHeaderViewHeight;
}

#pragma mark -编辑
-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    _selectedCellIndex=textField.tag;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self registerForKeyboardNotifications];
}



-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)registerForKeyboardNotifications
{
    //键盘出现
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                             name:UIKeyboardDidShowNotification object:nil];
    
    
    //键盘隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}



//键盘出现
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    TextFieldCell * cell=_cells[_selectedCellIndex];
    CGFloat top=0;
    if (_selectedCellIndex<[_group[0] count])
    {
         top=cell.frame.size.height*_selectedCellIndex+kHeaderViewHeight;
    }
    else
    {
        top=cell.frame.size.height*_selectedCellIndex+2*kHeaderViewHeight;
    }
    [UIView animateWithDuration:0.3f animations:^
    {
         _tableView.contentOffset=CGPointMake(0, top+_originalOffset.y);
    }];
}

//键盘隐藏
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
        [UIView animateWithDuration:0.3f animations:^
        {
            _tableView.contentOffset=_originalOffset;
            
        }];
}

@end
