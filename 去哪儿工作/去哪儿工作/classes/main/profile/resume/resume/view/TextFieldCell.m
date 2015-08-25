//
//  TextFieldCell.m
//  parttime
//
//  Created by 孙硕磊 on 4/24/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "TextFieldCell.h"
#import "TextFieldModel.h"
#import "NSDate+Format.h"


@interface TextFieldCell ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSArray * _components;
}

@end
@implementation TextFieldCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self createSubViews];
    }
    return self;
}

-(void) createSubViews
{
    self.textField=[[UITextField alloc] init];
    _textField.font=GlobalFont;
    _textField.leftViewMode=UITextFieldViewModeAlways;
    _textField.layer.borderColor=[GlobalSeparatorColor CGColor];
    _textField.layer.borderWidth=GlobalSeparatorHeight;
    _leftLabel=[self textFieldLeftLabel];
    _textField.leftView=_leftLabel;
    [self.contentView addSubview:_textField];
    
}

-(void) setTag:(NSInteger)tag
{
    [super setTag:tag];
    _textField.tag=tag;
}

#pragma mark -设置键盘
-(void) customKeyboard
{
    _textField.clearButtonMode=UITextFieldViewModeWhileEditing;
    _textField.inputAccessoryView=[self toolBar];
    if ( _textFieldModel.keyboardType==TextFieldKeyBoardTypeDate)
    {
        [self customDateKeyboard];
    }
    else if ( _textFieldModel.keyboardType==TextFieldKeyBoardTypeAge)
    {
        [self customAgeKeyBoard];
    }
    else if( _textFieldModel.keyboardType==TextFieldKeyBoardTypeGender)
    {
        [self customGenderKeyBoard];
    }
    else if ( _textFieldModel.keyboardType==TextFieldKeyBoardTypePhone)
    {
        [self customPhoneKeyboard];
    }
    else if( _textFieldModel.keyboardType==TextFieldKeyBoardTypeEmail)
    {
        _textField.keyboardType=UIKeyboardTypeEmailAddress;
    }
    else if(_textFieldModel.keyboardType==TextFieldKeyBoardTypeNumber)
    {
        _textField.keyboardType=UIKeyboardTypeNumberPad;
    }
   
}

#pragma mark 电话
-(void) customPhoneKeyboard
{
     _textField.keyboardType=UIKeyboardTypeNumberPad;
    // _textField.inputAccessoryView=[self toolBar];
}

#pragma mark 日期键盘
-(void) customDateKeyboard
{
    //日期键盘
    UIDatePicker * datePicker=[[UIDatePicker alloc] init];
    datePicker.minimumDate=[[NSDate alloc] initWithTimeIntervalSince1970:0];
    datePicker.maximumDate=[[NSDate alloc] initWithTimeIntervalSinceNow:10*365*24*60*60];

    datePicker.backgroundColor=[UIColor whiteColor];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans"];
   // _textField.inputAccessoryView=[self toolBar];
    _textField.inputView=datePicker;
}

#pragma mark 年龄键盘
-(void) customAgeKeyBoard
{
    //数据
    NSMutableArray * data=[NSMutableArray array];
    for (NSUInteger i=14; i<=100; i++)
    {
        [data addObject:[NSString stringWithFormat:@"%lu",i]];
    }
    _components=@[data.copy];
    //年龄
    UIPickerView * pickerView=[[UIPickerView alloc] init];
    pickerView.dataSource=self;
    pickerView.delegate=self;
    pickerView.showsSelectionIndicator=YES;
    pickerView.backgroundColor=[UIColor whiteColor];
  //  _textField.inputAccessoryView=[self toolBar];
    _textField.inputView=pickerView;
}


#pragma mark 性别键盘
-(void) customGenderKeyBoard
{
    //数据
    NSArray * genderArray=@[@"保密",@"女",@"男"];
    _components=@[genderArray];
    //性别
    UIPickerView * pickerView=[[UIPickerView alloc] init];
    pickerView.dataSource=self;
    pickerView.delegate=self;
    pickerView.showsSelectionIndicator=YES;
    pickerView.backgroundColor=[UIColor whiteColor];
  //  _textField.inputAccessoryView=[self toolBar];
    _textField.inputView=pickerView;
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _components.count;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray * data=_components[component];
    return data.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray * data=_components[component];
    return data[row];
}

#pragma mark - 辅助视图

-(UIToolbar *) toolBar
{
    //辅助视图
    UIBarButtonItem *flexibleItem=[[UIBarButtonItem alloc]  initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneItem=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(done:)];
    doneItem.tintColor=[UIColor blackColor];
    UIToolbar * toolbar=[[UIToolbar alloc] init];
    toolbar.translucent=NO;
    toolbar.backgroundColor=[UIColor whiteColor];
    toolbar.frame=CGRectMake(0, 0, self.frame.size.width, 44);
    [toolbar setItems:@[flexibleItem,doneItem]];
    return toolbar;
}

-(void) done:(UIBarButtonItem *) barButtonItem
{
    if(_textFieldModel.keyboardType==TextFieldKeyBoardTypeDate)
    {
        UIDatePicker * datePicker=(UIDatePicker*) _textField.inputView;
        NSDate * date=datePicker.date;
        _textField.text=[NSDate stringFromDate:date];
    }
    else if(_textFieldModel.keyboardType==TextFieldKeyBoardTypeAge||_textFieldModel.keyboardType==TextFieldKeyBoardTypeGender)
    {
        UIPickerView * pickerView=(UIPickerView *) _textField.inputView;
        NSUInteger row=[pickerView selectedRowInComponent:0];
        NSArray * data=_components[0];
        _textField.text=data[row];
    }
    [_textField resignFirstResponder];
}
#pragma mark -设置模型
-(void) setTextFieldModel:(TextFieldModel *)textFieldModel
{
    _textFieldModel=textFieldModel;
    _leftLabel.text=textFieldModel.title;
    _textField.text=textFieldModel.content;
    _textField.enabled=textFieldModel.isEditable;
    _textField.userInteractionEnabled=textFieldModel.isEditable;
    [self customKeyboard];
}
#pragma mark - 文本域左侧视图
-(UILabel *) textFieldLeftLabel
{
    UILabel * leftLabel=[[UILabel alloc] init];
    leftLabel.textAlignment=NSTextAlignmentCenter;
    leftLabel.font=GlobalFont;
    leftLabel.textColor=GlobalLightBlackTextColor;
    return leftLabel;
}

#pragma mark -布局子视图
-(void) layoutSubviews
{
    CGFloat width=self.frame.size.width;
    CGFloat height=self.frame.size.height;
    _textField.frame=CGRectMake(0, 0, width, height);
    if (_leftLabelWidth==0)
    {
        _leftLabelWidth=60;
    }
    _textField.leftView.frame=CGRectMake(0, 0, _leftLabelWidth, height);
}


@end

