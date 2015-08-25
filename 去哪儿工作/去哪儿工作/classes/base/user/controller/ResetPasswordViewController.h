//
//  ResetPasswordViewController.h
//  parttime
//
//  Created by 孙硕磊 on 5/12/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CheckCodeButton;

@interface ResetPasswordViewController : UIViewController
@property(nonatomic,strong) UITextField *usernameTextField;
@property(nonatomic,strong) UITextField *passwordTextField;
@property(nonatomic,strong) UITextField *repasswordTextField;
@property(nonatomic,strong) UITextField *checkCodeTextField;

@property(nonatomic,strong) CheckCodeButton    *sendCheckCodeButton;
@property(nonatomic,strong) UIButton           *submitButton;
@end

