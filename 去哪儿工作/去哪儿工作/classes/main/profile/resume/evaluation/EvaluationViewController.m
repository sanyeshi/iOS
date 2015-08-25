//
//  EvaluationViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/25/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "EvaluationViewController.h"
#import "Resume.h"
#import "EmployeeHttp.h"
#import "MBProgressHUD.h"
#import "AlertView.h"


#define kMargin 5
#define kTextViewHeight 200
#define kTipLabelHeight 20
#define kMaxWordCount   500
@interface EvaluationViewController ()
{
    UIView  * _contentView;
    UITextView * _textView;
    UILabel * _tipLabel;
}
@end

@implementation EvaluationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"自我评价";
    self.view.backgroundColor=GlobalTableViewBackgroundColor;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(submit:)];
    //内容视图
    CGFloat statusBarHeight=[[UIApplication sharedApplication] statusBarFrame].size.height;
    CGFloat navigationBarHeight=self.navigationController.navigationBar.frame.size.height;
    CGFloat contentViewX=kMargin;
    CGFloat contentViewY=statusBarHeight+navigationBarHeight+kMargin;
    CGFloat contentViewW=self.view.frame.size.width-2*kMargin;
    CGFloat contentViewH=kTextViewHeight+kTipLabelHeight+kMargin;
    _contentView=[[UIView alloc] init];
    _contentView.frame=CGRectMake(contentViewX,contentViewY, contentViewW, contentViewH);
    _contentView.layer.cornerRadius=kMargin;
    _contentView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        self.automaticallyAdjustsScrollViewInsets = NO; // Avoid the top UITextView space, iOS7
    }
    //文本框
    _textView=[[UITextView alloc] init];
    _textView.frame=CGRectMake(kMargin,kMargin,contentViewW-2*kMargin, kTextViewHeight-kMargin);
    _textView.showsVerticalScrollIndicator=YES;
    _textView.text=self.resume.evaluation;
    _textView.delegate=self;
    [_contentView addSubview:_textView];
    
    _tipLabel=[[UILabel alloc] init];
    _tipLabel.font=GlobalFont;
    _tipLabel.textColor=GlobalBackgroundTextColor;
    _tipLabel.textAlignment=NSTextAlignmentRight;
    _tipLabel.text=[NSString stringWithFormat:@"还可以输入%ld个字",kMaxWordCount-self.resume.evaluation.length];
    _tipLabel.frame=CGRectMake(kMargin,kTextViewHeight,contentViewW-2*kMargin, kTipLabelHeight);
    _tipLabel.hidden=YES;
    [_contentView  addSubview:_tipLabel];
}

#pragma mark -保存
-(void) submit:(UIBarButtonItem *) barButtonItem
{
    
    NSString * string=_textView.text;
    if ([string length]==0)
    {
        AlertView * alertView=[[AlertView alloc] init];
        alertView.title=@"内容为空";
        [alertView show];
        return;
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = @"更新中";
    [hud show:YES];
    
    [EmployeeHttp updateEmployeeEvaluationWithString:string success:^(BOOL isSuccess)
    {
        [hud removeFromSuperview];
        if (isSuccess)
        {
            self.resume.evaluation=string;
        }
    }
    fail:^
    {
        [hud removeFromSuperview];
    }];
}

- (void)textViewDidChange:(UITextView *)textView
{
    _tipLabel.hidden=NO;
    if (textView.text.length>kMaxWordCount)
    {
        textView.text=[textView.text substringToIndex:kMaxWordCount];
    }
    _tipLabel.text=[NSString stringWithFormat:@"还可以输入%lu",kMaxWordCount- textView.text.length];
}
#warning 确认、完成、回车

@end
