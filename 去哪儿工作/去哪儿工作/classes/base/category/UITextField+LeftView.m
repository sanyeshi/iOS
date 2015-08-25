//
//  UITextField+LeftView.m
//  parttime
//
//  Created by 孙硕磊 on 5/12/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "UITextField+LeftView.h"

#define kTextFieldFont       GlobalFont
#define kBorderColor         GlobalSeparatorColor
#define kLeftLabelFont       GlobalFont
#define kLeftLabelTextColor  GlobalLightBlackTextColor

@implementation UITextField (LeftView)

#pragma mark -文本域
+(UITextField *) textFieldWithLeftViewImageName:(NSString *) imageName placeholder:(NSString *) placeholder
{
    UITextField * textField=[[UITextField alloc] init];
    textField.font=kTextFieldFont;
    textField.placeholder=placeholder;
    textField.layer.borderColor=[kBorderColor CGColor];
    textField.layer.borderWidth=1;
    textField.leftViewMode=UITextFieldViewModeAlways;
    
    UIImageView * imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.contentMode=UIViewContentModeCenter;
    imageView.clipsToBounds=YES;
    textField.leftView=imageView;
    
    return textField;
}

+(UITextField *) textFieldWithTitle:(NSString *) title placeholder:(NSString *) placeholder
{
    UITextField * textField=[[UITextField alloc] init];
    textField.font=kTextFieldFont;
    textField.placeholder=placeholder;
    textField.layer.borderColor=[kBorderColor CGColor];
    textField.layer.borderWidth=1;
    textField.leftViewMode=UITextFieldViewModeAlways;
    
    UILabel * leftLabel=[[UILabel alloc] init];
    leftLabel.textAlignment=NSTextAlignmentCenter;
    leftLabel.text=title;
    leftLabel.font=kLeftLabelFont;
    leftLabel.textColor=kLeftLabelTextColor;
    
    textField.leftView=leftLabel;
    return textField;
}

@end
