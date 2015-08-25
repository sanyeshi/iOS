//
//  JobDetailView.h
//  parttime
//
//  Created by 孙硕磊 on 4/5/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JobDetailView;
@class Job;

@protocol JobDetailViewDelegate <NSObject>
-(void) jobDetailView:(JobDetailView *) jobDetailView didClickCompanyInfoButton:(UIButton *) companyInfoButton;
-(void) jobDetailView:(JobDetailView *) jobDetailView didClickApplicateButton:(UIButton *) applicateButton;
@end

@interface JobDetailView : UIView
@property(nonatomic,assign) id<JobDetailViewDelegate> jobDetailDelegate;
//头部
@property(nonatomic,strong) UILabel  * titleLabel;           //工作标题
@property(nonatomic,strong) UILabel  * salaryLabel;          //薪资
@property(nonatomic,strong) UILabel  * publishDateLabel;     //发布日期
//详情
@property(nonatomic,strong) UILabel  * companyNameLabel;     //商家名
@property(nonatomic,strong) UIButton * companyInfoButton;
@property(nonatomic,strong) UILabel  * salaryPayFormLabel;   //支付方式
@property(nonatomic,strong) UILabel  * durationLabel;        //工作持续日期
@property(nonatomic,strong) UILabel  * recruitNumLabel;      //招聘人数
@property(nonatomic,strong) UILabel  * infoLabel;            //工作描述
@property(nonatomic,strong) UILabel  * addressLabel;         //工作地点
@property(nonatomic,strong) UILabel  * contactNameLabel;     //联系人
@property(nonatomic,strong) UILabel  * cellPhoneLabel;       //联系电话
@property(nonatomic,strong) UILabel  * tipLabel;             //提示
//底部
@property(nonatomic,strong) UILabel  * applicateNumLabel;    //已申请人数
@property(nonatomic,strong) UIButton * applicateButton;

@property(nonatomic,assign) BOOL       isApplied;
@property(nonatomic,strong) Job      * job;

@end
