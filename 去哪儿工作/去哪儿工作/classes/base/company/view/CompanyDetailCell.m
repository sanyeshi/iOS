//
//  CompanyDetailHeaderView.m
//  parttime
//
//  Created by 孙硕磊 on 4/5/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CompanyDetailCell.h"
#import "PhotoBowserViewController.h"
#import "CompanyDetaiCellFrame.h"
#import "Company.h"
#import "UIImageView+WebCache.h"

#define kMargin 10
#define KMargin_2 5
#define kCompanyImageViewHeight 160
#define kHeaderViewHeight 230
#define kDetailViewHeight 200

@interface CompanyDetailCell()
{
    UIView * _headerView;
    UIView * _headerSeparatorLine;
    
    UIView * _detailView;
    UILabel * _detailTipLabel;
    UILabel * _companyAddressTipLabel;
    UILabel * _contactNameTipLabel;
    UILabel * _cellphoneTipLabel;
    UILabel * _authenticationTypeTipLabel;
    UILabel * _companyInfoTipLabel;

}
@end
@implementation CompanyDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
       [self createSubViews];
    }
    return self;
}
#pragma mark -创建子控件
-(void) createSubViews
{
    [self createHeaderViews];
    [self createDetailViews];
}
-(void) createHeaderViews
{
    _headerView=[[UIView alloc] init];
    self.backgroundColor=GlobalBackgroundColor;
    [self.contentView addSubview:_headerView];
    //商家图片
    self.companyImageView=[[UIImageView alloc] init];
    _companyImageView.contentMode=UIViewContentModeScaleToFill;
    _companyImageView.userInteractionEnabled=YES;
    //添加手势
    /*
    UITapGestureRecognizer *tapGestureRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(browseCompanyImages:)];
    [_companyImageView addGestureRecognizer:tapGestureRecognizer];
     */
    [_headerView addSubview:_companyImageView];
    
    //商家名
    _companyNameLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:_headerView];
    //认证
    _authenticationLabel=[self addLabelWithFont:GlobalSmallFont textColor:GlobalWhiteTextColor toView:_headerView];
    _authenticationLabel.textAlignment=NSTextAlignmentCenter;
    _authenticationLabel.backgroundColor=RGBColor(238, 190, 62);
    _authenticationLabel.layer.cornerRadius=1.0f;
    //分割线
    _headerSeparatorLine=[[UIView alloc] init];
    _headerSeparatorLine.backgroundColor=GlobalSeparatorColor;
    [_headerView addSubview:_headerSeparatorLine];
}

-(void) createDetailViews
{
    _detailView=[[UIView alloc] init];
    _detailView.backgroundColor=GlobalBackgroundColor;
    [self.contentView addSubview:_detailView];
    //提示
    _detailTipLabel=[self addLabelWithFont:GlobalBoldFont textColor:GlobalBlackTextColor toView:_detailView];
    _detailTipLabel.text=@"公司概况";
    
    //公司地址
    _companyAddressTipLabel=[self addTipLabelWithTitle:@"地址"];
    _companyAddressLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:_detailView];
    //联系人
    _contactNameTipLabel=[self addTipLabelWithTitle:@"联系人"];
    _contactNameLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:_detailView];
    //联系电话
    _cellphoneTipLabel=[self addTipLabelWithTitle:@"联系电话"];
    _cellphoneLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:_detailView];

    //认证类型
    _authenticationTypeTipLabel=[self addTipLabelWithTitle:@"认证类型"];
    _authenticationTypeLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:_detailView];
    //商家信息
    _companyInfoTipLabel=[self addTipLabelWithTitle:@"公司简介"];
    _companyInfoLabel=[self addLabelWithFont:GlobalFont textColor:GlobalBlackTextColor toView:_detailView];
    _companyInfoLabel.numberOfLines=0;
    
    
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
#pragma mark --布局子控件
-(void) layoutSubviews
{
    [super layoutSubviews];
    [self layoutHeaderViews];
}

-(void) layoutHeaderViews
{
    CGFloat width=self.frame.size.width;
    _headerView.frame=CGRectMake(0, 0, width, kHeaderViewHeight);
    //商家图片
    _companyImageView.frame=CGRectMake(0, 0, width, kCompanyImageViewHeight);
   //商家名
    CGFloat companyNameLabelX=kMargin;
    CGFloat companyNameLabelY=kCompanyImageViewHeight+kMargin;
    CGFloat companyNameLabelWidth=width-companyNameLabelX;
    CGFloat companyNameLabelHeight=20;
    _companyNameLabel.frame=CGRectMake(companyNameLabelX, companyNameLabelY, companyNameLabelWidth, companyNameLabelHeight);
    //认证
    CGFloat authenticationLabelX=companyNameLabelX;
    CGFloat authenticationLabelY=CGRectGetMaxY(_companyNameLabel.frame)+kMargin*0.5;
    CGFloat authenticationLabelWidth=60;
    CGFloat authenticationLabelHeight=20;
    _authenticationLabel.frame=CGRectMake(authenticationLabelX, authenticationLabelY, authenticationLabelWidth, authenticationLabelHeight);
    //分割线
    CGFloat separatorLineY=CGRectGetMaxY(_authenticationLabel.frame)+kMargin;
    _headerSeparatorLine.frame=CGRectMake(0, separatorLineY, width, GlobalSeparatorHeight);
    
}

#pragma mark - 位置大小
-(void) setDetailFrame:(CompanyDetaiCellFrame *) detailFrame
{
    _detailView.frame=detailFrame.detailViewFrame;
    //提示(公司概况)
    _detailTipLabel.frame=detailFrame.detailTipLabelFrame;
    //公司地址
    _companyAddressTipLabel.frame=detailFrame.companyAddressTipLabelFrame;
    _companyAddressLabel.frame=detailFrame.companyAddressLabelFrame;
    //联系人
    _contactNameTipLabel.frame=detailFrame.contactNameTipLabelFrame;
    _contactNameLabel.frame=detailFrame.contactNameLabelFrame;
    //联系电话
    _cellphoneTipLabel.frame=detailFrame.cellphoneTipLabelFrame;
    _cellphoneLabel.frame=detailFrame.cellphoneLabelFrame;
    //认证类型
    _authenticationTypeTipLabel.frame=detailFrame.authenticationTypeTipLabelFrame;
    _authenticationTypeLabel.frame=detailFrame.authenticationTypeLabelFrame;
    //公司简介
    _companyInfoTipLabel.frame=detailFrame.companyInfoTipLabelFrame;
    _companyInfoLabel.frame=detailFrame.companyInfoLabelFrame;
}



#pragma mark - 设置数据
- (void)setCompany:(Company *)company
{
    if (company==nil)
    {
        return;
    }
    //商家图片
    [_companyImageView sd_setImageWithURL:[NSURL URLWithString:company.imageUrlStr]];
    //商家名
    _companyNameLabel.text=company.companyName;
    //认证
    if (company.isVerified)
    {
       _authenticationLabel.text=@"认证商家";
    }
    else
    {
       _authenticationLabel.text=@"待认证商家";
    }
       //公司地址
    _companyAddressLabel.text=company.address;
    //联系人
    _contactNameLabel.text=company.contactName;
    //联系电话
    _cellphoneLabel.text=company.phone;
    //认证类型
    _authenticationTypeLabel.text=_authenticationLabel.text;
    //公司信息
    _companyInfoLabel.text=company.info;
}
@end
