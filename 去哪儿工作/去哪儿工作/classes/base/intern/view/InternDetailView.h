//
//  JobDetailView.h
//  parttime
//
//  Created by 孙硕磊 on 4/5/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InternDetailView;
@class Intern;

@protocol InternDetailViewDelegate <NSObject>
-(void) internDetailView:(InternDetailView *) internDetailView didClickCompanyInfoButton:(UIButton *) companyInfoButton;
-(void) internDetailView:(InternDetailView *) internDetailView didClickApplicateButton:(UIButton *) applicateButton;
@end

@interface InternDetailView : UIView
@property(nonatomic,assign) id<InternDetailViewDelegate> internDetailDelegate;
//头部
@property(nonatomic,strong) UILabel  * titleLabel;                 //工作标题
@property(nonatomic,strong) UILabel  * salaryLabel;                //薪资
@property(nonatomic,strong) UILabel  * publishDateLabel;           //发布日期
//详情
@property(nonatomic,strong) UILabel  * companyNameLabel;           //商家名
@property(nonatomic,strong) UIButton * companyInfoButton;
@property(nonatomic,strong) UILabel  * salaryPayFormLabel;         //支付方式
@property(nonatomic,strong) UILabel  * durationLabel;              //工作持续日期
@property(nonatomic,strong) UILabel  * recruitNumLabel;            //招聘人数
@property(nonatomic,strong) UILabel  * infoLabel;                  //工作描述
@property(nonatomic,strong) UILabel  * addressLabel;               //工作地点
@property(nonatomic,strong) UILabel  * contactNameLabel;           //联系人
@property(nonatomic,strong) UILabel  * cellPhoneLabel;             //联系电话
@property(nonatomic,strong) UILabel  * tipLabel;                   //提示
//底部
@property(nonatomic,strong) UILabel  * applicateNumLabel;          //已申请人数
@property(nonatomic,strong) UIButton * applicateButton;

-(void) setIntern:(Intern *)intern;
@end
