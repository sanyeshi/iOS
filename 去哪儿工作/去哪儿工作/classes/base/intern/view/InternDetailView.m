//
//  JobDetailView.m
//  parttime
//
//  Created by 孙硕磊 on 4/5/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "InternDetailView.h"
#import "Intern.h"

#define kMargin 5
#define kHeaderViewHeight 60

@interface InternDetailView ()
{
    UIScrollView * _scrollView;
   //头部
    UIView  * _headerView;
    UILabel * _salaryFormLabel;
    //详情
    UIView  * _detailView;
    UIView  * _separatorLine;
    UILabel * _salaryPayFormTipLabel;
    UILabel * _durationTipLabel;
    UILabel * _recruitNumTipLabel;
    UILabel * _infoTipLabel;
    UILabel * _addressTipLabel;
    UILabel * _contactNameTipLabel;
    UILabel * _cellphoneTipLabel;
    UILabel * _tipTipLabel;
    //底部
    UIView * _footerView;
    UIView * _footerSeparatorLine;
}
@end
@implementation InternDetailView
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
    [self addSubview:_scrollView];
    [self createScrollView];
}

-(void) createScrollView
{
    self.backgroundColor=GlobalBackgroundColor;
    _scrollView=[[UIScrollView alloc] init];
    _scrollView.backgroundColor=GlobalBackgroundColor;
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [self addSubview:_scrollView];
    [self createHeaderViews];
    [self createDetailViews];
}

-(void) createHeaderViews
{
    
    //头部
    _headerView=[[UIView alloc] init];
    _headerView.backgroundColor=GlobalBackgroundColor;
    [_scrollView addSubview:_headerView];
    //标题
    self.titleLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:_headerView];
    //薪资
    self.salaryLabel=[self addLabelWithFont:GlobalBigFont textColor:GlobalTintColor toView:_headerView];
    
    _salaryFormLabel=[self addLabelWithFont:GlobalSmallFont textColor:GlobalBlackTextColor toView:_headerView];
    //发布日期
    _publishDateLabel=[self addLabelWithFont:GlobalSmallFont textColor:GlobalBlackTextColor toView:_headerView];
   
}

-(void) createDetailViews
{
    //详情
    _detailView=[[UIView alloc] init];
    _detailView.backgroundColor=GlobalBackgroundColor;
    [_scrollView addSubview:_detailView];
    
    //商家名
    _companyNameLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:_detailView];
    
    //商家详情
    _companyInfoButton=[[UIButton alloc] init];
    _companyInfoButton.titleLabel.font=GlobalFont;
    [_companyInfoButton setTitleColor:GlobalTintColor forState:UIControlStateNormal];
    [_companyInfoButton setTitle:@"商家信息" forState:UIControlStateNormal];
    _companyInfoButton.layer.cornerRadius=5.0f;
    _companyInfoButton.layer.borderColor=[GlobalTintColor CGColor];
    _companyInfoButton.layer.borderWidth=1;
    [_companyInfoButton addTarget:self action:@selector(didClickCompanyInfoButton:) forControlEvents:UIControlEventTouchDown];
    [_detailView addSubview:_companyInfoButton];
    
    //分割线
    _separatorLine=[[UIView alloc] init];
    _separatorLine.backgroundColor=GlobalSeparatorColor;
    [_detailView addSubview:_separatorLine];
    
    //结算方式
    _salaryPayFormTipLabel=[self addTipLabelWithTitle:@"结算方式"];
    _salaryPayFormLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:_detailView];
    
    //工作日期
    _durationTipLabel=[self addTipLabelWithTitle:@"工作日期"];
    _durationLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:_detailView];
    
    //招聘人数
    _recruitNumTipLabel=[self addTipLabelWithTitle:@"招聘人数"];
    _recruitNumLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:_detailView];
    
    //职位描述
    _infoTipLabel=[self addTipLabelWithTitle:@"职位描述"];
    _infoLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:_detailView];
    _infoLabel.numberOfLines=0;
   
    //工作地址
    _addressTipLabel=[self addTipLabelWithTitle:@"工作地点"];
    _addressLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:_detailView];
  
    //联系人
    _contactNameTipLabel=[self addTipLabelWithTitle:@"联系人"];
    _contactNameLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:_detailView];
  
    //联系电话
    _cellphoneTipLabel=[self addTipLabelWithTitle:@"联系电话"];
    _cellPhoneLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:_detailView];
    //温馨提示
    _tipTipLabel=[self addTipLabelWithTitle:@"温馨提示"];
    _tipLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBackgroundTextColor toView:_detailView];
    _tipLabel.numberOfLines=0;
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
    UILabel * tipLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBackgroundTextColor toView:_detailView];
    tipLabel.text=title;
    return tipLabel;
}

-(void)layoutSubviews
{
    [self layoutScrollView];
}

-(void) layoutScrollView
{
    CGFloat width=self.frame.size.width;
    CGFloat height=self.frame.size.height;
    _scrollView.frame=CGRectMake(0, 0, width, height);
    [self layoutHeaderViews];
    [self layoutDetailViews];
}

-(void) layoutHeaderViews
{
    CGFloat width=self.frame.size.width;
    //头部
    _headerView.frame=CGRectMake(0, 0,width, kHeaderViewHeight);
    //工作标题
    _titleLabel.frame=CGRectMake(2*kMargin, kMargin, width-kMargin, 20);
    //薪资
    CGSize size = [_salaryLabel.text sizeWithAttributes:@{ NSFontAttributeName :GlobalBigFont}];
    CGFloat jobSalaryLabelX=2*kMargin;
    CGFloat jobSalaryLabelY=CGRectGetMaxY(_titleLabel.frame)+kMargin;
    _salaryLabel.frame=CGRectMake(jobSalaryLabelX,jobSalaryLabelY, size.width,size.height);
    
    size=[_salaryFormLabel.text sizeWithAttributes:@{ NSFontAttributeName :GlobalSmallFont}];
    CGFloat jobSalaryFormLabelX=CGRectGetMaxX(_salaryLabel.frame);
    CGFloat jobSalaryFormLabelY=CGRectGetMaxY(_salaryLabel.frame)-size.height;
    _salaryFormLabel.frame=CGRectMake(jobSalaryFormLabelX, jobSalaryFormLabelY,size.width,size.height);
    
    //发布日期
    size=[_publishDateLabel.text sizeWithAttributes:@{ NSFontAttributeName :GlobalSmallFont}];
    CGFloat jobPublishDateLabelX=self.frame.size.width-kMargin-size.width;
    CGFloat jobPublishDateLabelY=jobSalaryFormLabelY;
    _publishDateLabel.frame=CGRectMake(jobPublishDateLabelX, jobPublishDateLabelY, size.width, size.height);
    
}
-(void) layoutDetailViews
{
    CGFloat width=self.frame.size.width;
    CGFloat height=self.frame.size.height;
    //详情
    CGFloat detailViewX=0;
    CGFloat detailViewY=CGRectGetMaxY(_headerView.frame);
    CGFloat detailViewHeight=height-detailViewY;
    _detailView.frame=CGRectMake(detailViewX,detailViewY ,width,detailViewHeight);
    
    CGFloat companyInfoButtonWidth=80;
    CGFloat companyInfoButtonHeight=30;
    CGFloat companyInfoButtonX=width-companyInfoButtonWidth-2*kMargin;
    CGFloat companyInfoButtonY=kMargin;
    _companyInfoButton.frame=CGRectMake(companyInfoButtonX,companyInfoButtonY, companyInfoButtonWidth, companyInfoButtonHeight);
    //公司名称
    CGSize size=[_companyNameLabel.text sizeWithAttributes:@{ NSFontAttributeName :GlobalFont}];
    CGPoint center=CGPointMake(kMargin+size.width*0.5, _companyInfoButton.center.y);
    _companyNameLabel.bounds=CGRectMake(0,0,size.width, size.height);
    _companyNameLabel.center=center;
    //分割线
    CGFloat separatorLineX=0;
    CGFloat separatorLineY=CGRectGetMaxY(_companyInfoButton.frame)+kMargin;
    _separatorLine.frame=CGRectMake(separatorLineX, separatorLineY, width, GlobalSeparatorHeight);
    
    CGFloat tipLabelX=2*kMargin;
    CGFloat tipLabelY=CGRectGetMaxY(_separatorLine.frame)+kMargin;
    CGFloat tipLabelWidth=60;
    CGFloat tipLabelHeight=20;
    
    CGFloat labelX=tipLabelX+tipLabelWidth;
    CGFloat labelY=tipLabelY;
    CGFloat labelWidth=width-labelX-kMargin*2;
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
    _cellPhoneLabel.frame=CGRectMake(labelX, labelY, labelWidth, labelHeight);
    
    //温馨提示
    tipLabelY+=tipLabelHeight+kMargin;
    labelY=tipLabelY;
    bound=[_tipLabel.text boundingRectWithSize:CGSizeMake(labelWidth,INT64_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName :GlobalFont} context:nil];
    _tipTipLabel.frame=CGRectMake(tipLabelX,tipLabelY,tipLabelWidth, tipLabelHeight);
    _tipLabel.frame=CGRectMake(labelX, labelY, labelWidth,bound.size.height);
    //滚动范围
    CGFloat contentHeight=CGRectGetMaxY(_headerView.frame)+CGRectGetMaxY(_tipLabel.frame);
    if (contentHeight>(_scrollView.frame.size.height-64))
    {
        _scrollView.contentSize=CGSizeMake(width,contentHeight);
    }
}

-(void) didClickCompanyInfoButton:(UIButton *) button
{
    [_internDetailDelegate internDetailView:self didClickCompanyInfoButton:button];
}
-(void) didClickApplicateButton:(UIButton *) button
{
    [_internDetailDelegate internDetailView:self didClickApplicateButton:button];
}

#pragma mark -设置数据
-(void) setIntern:(Intern *)intern
{
    _titleLabel.text=intern.title;
    _salaryLabel.text=[NSString stringWithFormat:@"%lu",intern.salary];
    _salaryFormLabel.text=@"元/月";
    _publishDateLabel.text=[NSString stringWithFormat:@"发布日期:%@",intern.publishTime];
    
    _companyNameLabel.text=intern.companyName;
    _salaryPayFormLabel.text=@"日结";
    _durationLabel.text=intern.workTime;
    _recruitNumLabel.text=[NSString stringWithFormat:@"%lu",intern.amount];
    _infoLabel.text=intern.info;
    _addressLabel.text=intern.address;
    _contactNameLabel.text=intern.contactName;
    _cellPhoneLabel.text=intern.contactPhone;
    _tipLabel.text=@"同学们，兼职所有的岗位都不收费哦。如果遇到商家或企业收取岗位信息未提出的收费要求，请一律拒绝，你也可以及时举报。\n外出兼职一定要注意人身安全，财产安全，交通安全哦！\n我们的客服电话：400-090-1222";
     _applicateNumLabel.text=[NSString stringWithFormat:@"已有%lu人申请",intern.appliedAmount];
    [self layoutSubviews];
}
@end
