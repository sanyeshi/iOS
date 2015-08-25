//
//  MyJobDetailView.m
//  parttime
//
//  Created by 孙硕磊 on 5/15/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "MyJobDetailView.h"
#import "Application.h"
#import "Job.h"


#define kHeaderImageViewHeight 160
#define kStateImageViewHeight  80
#define kMargin 10
#define kMargin_2 5
@interface MyJobDetailView ()
{
    UIImageView * _headerImageView;
    UIButton    * _stateButton;
    UILabel     * _jobTitleLabel;
    UILabel     * _salaryLabel;
    UILabel     * _applicationNumLabel;
    UIImageView * _stateImageView;
    UILabel     * _companyNameLabel;
    UILabel     * _jobIntroduceLabel;
    
    UIView      *_separator;
    
    UILabel * _salaryPayFormTipLabel;
    UILabel * _durationTipLabel;
    UILabel * _recruitNumTipLabel;
    UILabel * _infoTipLabel;
    UILabel * _addressTipLabel;
    UILabel * _contactNameTipLabel;
    UILabel * _cellphoneTipLabel;
    
    
    UILabel * _salaryPayFormLabel;
    UILabel * _durationLabel;
    UILabel * _recruitNumLabel;
    UILabel * _infoLabel;
    UILabel * _addressLabel;
    UILabel * _contactNameLabel;
    UILabel * _cellphoneLabel;
    
}
@end

@implementation MyJobDetailView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self createSubViews];
    }
    return self;
}

-(void) createSubViews
{
    //图像
    _headerImageView=[[UIImageView alloc] init];
    _headerImageView.contentMode=UIViewContentModeScaleAspectFill;
    _headerImageView.clipsToBounds=YES;
    [self addSubview:_headerImageView];
    
    //状态
    _stateButton=[[UIButton alloc] init];
    _stateButton.userInteractionEnabled=NO;
    _stateButton.titleLabel.font=GlobalFont;
    [_stateButton setBackgroundImage:[UIImage imageNamed:@"state.png"] forState:UIControlStateNormal];
    [_headerImageView addSubview:_stateButton];
    
    //工作标题
    _jobTitleLabel=[[UILabel alloc] init];
    _jobTitleLabel.font=GlobalBoldFont;
    _jobTitleLabel.textColor=GlobalBlackTextColor;
    [self addSubview:_jobTitleLabel];
    
    //薪资
    _salaryLabel=[[UILabel alloc] init];
    _salaryLabel.font=GlobalFont;
    _salaryLabel.textColor=GlobalTintColor;
    [self addSubview:_salaryLabel];
    
    //申请人数
    _applicationNumLabel=[[UILabel alloc] init];
    _applicationNumLabel.font=GlobalSmallFont;
    _applicationNumLabel.textColor=GlobalBackgroundTextColor;
    _applicationNumLabel.textAlignment=NSTextAlignmentRight;
    [self addSubview:_applicationNumLabel];
    
    //状态图
    _stateImageView=[[UIImageView alloc] init];
    _stateImageView.contentMode=UIViewContentModeScaleAspectFit;
    _stateImageView.clipsToBounds=YES;
    [self addSubview:_stateImageView];
    
    _companyNameLabel=[[UILabel alloc] init];
    _companyNameLabel.font=GlobalBoldFont;
    _companyNameLabel.textColor=GlobalBlackTextColor;
    [self addSubview:_companyNameLabel];
    
    //职位描述
    _jobIntroduceLabel=[[UILabel alloc] init];
    _jobIntroduceLabel.font=GlobalFont;
    _jobIntroduceLabel.textColor=GlobalBlackTextColor;
    [self addSubview:_jobIntroduceLabel];
    
    //分割线
    _separator=[[UIView alloc] init];
    _separator.backgroundColor=GlobalSeparatorColor;
    [self addSubview:_separator];
    
    
    //结算方式
    _salaryPayFormTipLabel=[self addTipLabelWithTitle:@"结算方式"];
    _salaryPayFormLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:self];
    
    //工作日期
    _durationTipLabel=[self addTipLabelWithTitle:@"工作日期"];
    _durationLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:self];
    
    //招聘人数
    _recruitNumTipLabel=[self addTipLabelWithTitle:@"招聘人数"];
    _recruitNumLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:self];
    
    //职位描述
    _infoTipLabel=[self addTipLabelWithTitle:@"职位描述"];
    _infoLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:self];
    _infoLabel.numberOfLines=0;
    
    //工作地址
    _addressTipLabel=[self addTipLabelWithTitle:@"工作地点"];
    _addressLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:self];
    
    //联系人
    _contactNameTipLabel=[self addTipLabelWithTitle:@"联系人"];
    _contactNameLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:self];
    
    //联系电话
    _cellphoneTipLabel=[self addTipLabelWithTitle:@"联系电话"];
    _cellphoneLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:self];
}


-(UILabel *) addLabelWithFont:(UIFont *) font textColor:(UIColor*) textColor toView:(UIView *)view
{
    UILabel * label=[[UILabel alloc] init];
    label.font=font;
    label.textColor=textColor;
    [view addSubview:label];
    return label;
}
-(UILabel *)addTipLabelWithTitle:(NSString *) title;
{
    UILabel * tipLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBackgroundTextColor toView:self];
    tipLabel.text=title;
    return tipLabel;
}



-(void) layoutSubviews
{
    CGFloat width=self.frame.size.width;
    _headerImageView.frame=CGRectMake(0, 0, width, kHeaderImageViewHeight);
    _stateButton.frame=CGRectMake(width-98,kHeaderImageViewHeight-kMargin-38, 98, 38);
    
    //工作标题
    _jobTitleLabel.frame=CGRectMake(kMargin, kHeaderImageViewHeight+kMargin, width-kMargin, 20);
    _salaryLabel.frame=CGRectMake(kMargin,CGRectGetMaxY(_jobTitleLabel.frame)+kMargin,100, 20);
    _applicationNumLabel.frame=CGRectMake(CGRectGetMaxX(_salaryLabel.frame)+kMargin, _salaryLabel.frame.origin.y,width-(CGRectGetMaxX(_salaryLabel.frame)+kMargin)-kMargin, 20);
    //状态图
    _stateImageView.frame=CGRectMake(0, CGRectGetMaxY(_applicationNumLabel.frame), width, kStateImageViewHeight);
    _companyNameLabel.frame=CGRectMake(kMargin,CGRectGetMaxY(_stateImageView.frame), width-kMargin, 20);
    _jobIntroduceLabel.frame=CGRectMake(kMargin,CGRectGetMaxY(_companyNameLabel.frame)+kMargin, width-kMargin, 20);
    _separator.frame=CGRectMake(0,CGRectGetMaxY(_jobIntroduceLabel.frame)+kMargin_2, width,1);
    
    //详情
    CGFloat tipLabelX=kMargin;
    CGFloat tipLabelY=CGRectGetMaxY(_separator.frame)+kMargin;
    CGFloat tipLabelWidth=60;
    CGFloat tipLabelHeight=20;
    
    CGFloat labelX=tipLabelX+tipLabelWidth+kMargin;
    CGFloat labelY=tipLabelY;
    CGFloat labelWidth=width-labelX-kMargin;
    CGFloat labelHeight=tipLabelHeight;
    //结算方式
    _salaryPayFormTipLabel.frame=CGRectMake(tipLabelX,tipLabelY,tipLabelWidth, tipLabelHeight);
    _salaryPayFormLabel.frame=CGRectMake(labelX, labelY, labelWidth, labelHeight);
    
    //工作日期
    tipLabelY+=tipLabelHeight+kMargin;
    labelY=tipLabelY;
    _durationTipLabel.frame=CGRectMake(tipLabelX,tipLabelY,tipLabelWidth, tipLabelHeight);
    _durationLabel.frame=CGRectMake(labelX, labelY, labelWidth, labelHeight);
    
    //招聘人数
    tipLabelY+=tipLabelHeight+kMargin;
    labelY=tipLabelY;
    _recruitNumTipLabel.frame=CGRectMake(tipLabelX,tipLabelY,tipLabelWidth, tipLabelHeight);
    _recruitNumLabel.frame=CGRectMake(labelX, labelY, labelWidth, labelHeight);
    
    //工作信息
    tipLabelY+=tipLabelHeight+kMargin;
    labelY=tipLabelY;
    CGRect bound=[_infoLabel.text boundingRectWithSize:CGSizeMake(labelWidth,INT64_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName :GlobalFont} context:nil];
    _infoTipLabel.frame=CGRectMake(tipLabelX,tipLabelY,tipLabelWidth, tipLabelHeight);
    _infoLabel.frame=CGRectMake(labelX, labelY, labelWidth,bound.size.height);
    
    //工作地址
    if (_infoLabel.frame.size.height!=0)
    {
        tipLabelY+=_infoLabel.frame.size.height+kMargin;
    }
    else
    {
        tipLabelY+=_infoTipLabel.frame.size.height+kMargin;
    }
    labelY=tipLabelY;
    _addressTipLabel.frame=CGRectMake(tipLabelX,tipLabelY,tipLabelWidth, tipLabelHeight);
    _addressLabel.frame=CGRectMake(labelX, labelY, labelWidth, labelHeight);
    
    //联系人
    tipLabelY+=tipLabelHeight+kMargin;
    labelY=tipLabelY;
    _contactNameTipLabel.frame=CGRectMake(tipLabelX,tipLabelY,tipLabelWidth, tipLabelHeight);
    _contactNameLabel.frame=CGRectMake(labelX, labelY, labelWidth, labelHeight);
    
    //联系电话
    tipLabelY+=tipLabelHeight+kMargin;
    labelY=tipLabelY;
    _cellphoneTipLabel.frame=CGRectMake(tipLabelX,tipLabelY,tipLabelWidth, tipLabelHeight);
    _cellphoneLabel.frame=CGRectMake(labelX, labelY, labelWidth, labelHeight);
    self.contentSize=CGSizeMake(width, CGRectGetMaxY(_cellphoneLabel.frame)+kMargin);
}

-(void) setApplication:(Application *)application
{
    _application=application;
    Job * job=application.job;
    //刷新
    _headerImageView.image=[UIImage imageNamed:@"myJobDetailHeader.png"];
    NSString * state=@"已回绝";
    NSString * stateImageName=@"state_reject.png";
    if ([application.state isEqualToString:@"apply"])
    {
        state=@"报名中";
        stateImageName=@"state_confirm.png";
    }
    else if([application.state isEqualToString:@"accept"])
    {
        state=@"已接受";
        stateImageName=@"state_card.png";
    }
    else if([application.state isEqualToString:@"reject"])
    {
        state=@"已回绝";
        stateImageName=@"state_reject.png";
    }
    [_stateButton setTitle:state forState:UIControlStateNormal];
    _jobTitleLabel.text=job.title;
    _salaryLabel.text=[NSString stringWithFormat:@"￥%lu",job.salary];
    _applicationNumLabel.text=[NSString stringWithFormat:@"已申请:%lu人",job.appliedAmount];
    _stateImageView.image=[UIImage imageNamed:stateImageName];
    _companyNameLabel.text=job.companyName;
    _jobIntroduceLabel.text=@"职位描述";
    
    _salaryPayFormLabel.text=@"日结";
    _durationLabel.text=job.workTime;
    _recruitNumLabel.text=[NSString stringWithFormat:@"%lu",job.amount];
    _infoLabel.text=job.info;
    _addressLabel.text=job.address;
    _contactNameLabel.text=job.contactName;
    _cellphoneLabel.text=job.contactPhone;
    
    [self layoutSubviews];
}
@end
