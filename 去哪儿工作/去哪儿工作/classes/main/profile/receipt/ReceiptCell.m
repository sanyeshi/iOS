//
//  ReceiptCell.m
//  parttime
//
//  Created by 孙硕磊 on 5/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ReceiptCell.h"
#import "Receipt.h"
#import "Job.h"
#import "Company.h"
#import "UIImageView+WebCache.h"

#define kMargin   10
#define kIconImageViewWidth  60
#define kIconImageViewHeight 60
#define kBottomItemHeight    60
#define kReceiptViewHeight   140

@interface ReceiptCell ()
{
    UIView      * _receiptView;
    UIImageView * _backgroundImageView;
}
@end
@implementation ReceiptCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.backgroundColor=GlobalTableViewBackgroundColor;
        [self  createSubViews];
    }
    return self;
}

-(void) createSubViews
{
    UIImage * backgroundImage=[UIImage imageNamed:@"card_bg.png"];
    backgroundImage=[backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(5,5,5,5) resizingMode:UIImageResizingModeStretch];
    _backgroundImageView=[[UIImageView alloc] initWithImage:backgroundImage];
    [self.contentView addSubview:_backgroundImageView];
    
    
    _receiptView=[[UIView alloc] init];
    _receiptView.backgroundColor=GlobalBackgroundColor;
    [self.contentView addSubview:_receiptView];
    
    //头像
    self.iconImageView=[[UIImageView alloc] init];
    _iconImageView.layer.cornerRadius=kIconImageViewHeight*0.5;
    _iconImageView.clipsToBounds=YES;
    _iconImageView.contentMode=UIViewContentModeScaleAspectFit;
    [_receiptView addSubview:_iconImageView];
    
    //公司名称
    self.companyNameLabel=[self createLabelWithTextColor:GlobalBlackTextColor textFont:GlobalBigFont];
    
    //薪资
    self.totalSalaryLabel=[self createLabel];
    
    //工作日期
    self.workDateLabel=[self createLabel];
    
    //工作类型
    self.workTypeLabel=[self createLabelWithTextColor:GlobalWhiteTextColor textFont:GlobalBigFont];
    _workTypeLabel.textAlignment=NSTextAlignmentCenter;
    _workTypeLabel.backgroundColor=RGBColor(93, 131, 167);
    
    //工作薪资
    self.workSalaryLabel=[self createLabelWithTextColor:GlobalWhiteTextColor textFont:GlobalBigFont];
    _workSalaryLabel.textAlignment=NSTextAlignmentCenter;
    _workSalaryLabel.backgroundColor=RGBColor(160, 197, 103);
    
    //打卡
    self.button=[[UIButton alloc] init];
    _button.userInteractionEnabled=NO;
    _button.enabled=NO;
    _button.backgroundColor=RGBColor(253, 132, 133);
    _button.titleLabel.font=GlobalFont;
    [_button setTitleColor:GlobalWhiteTextColor forState:UIControlStateNormal];
    //[_button addTarget:self action:@selector(didPunchCard:) forControlEvents:UIControlEventTouchDown];
    [_receiptView addSubview:_button];
    
}

//创建标签
-(UILabel *) createLabel
{
    return [self createLabelWithTextColor:GlobalLightBlackTextColor textFont:GlobalFont];
}

-(UILabel *) createLabelWithTextColor:(UIColor *) textColor textFont:(UIFont *) textFont
{
    UILabel * label=[[UILabel alloc]init];
    label.textColor=textColor;
    label.font=textFont;
    [_receiptView addSubview:label];
    return label;
}

-(void) didPunchCard:(UIButton *) button
{
   // [_delegate cardCell:self didPunchCardAtIndex:_index];
}
//布局子视图
- (void)layoutSubviews
{
    CGFloat bottomItemWidth=100.0f;
    CGFloat receiptViewWidth=300.0f;
    if(iPhone5)
    {
        bottomItemWidth=100.0f;
        receiptViewWidth=300.0f;
    }
    else if (iPhone6)
    {
        bottomItemWidth=120.0f;
        receiptViewWidth=360.0f;
    }
    else if (iPhone6Plus)
    {
        bottomItemWidth=130.0f;
        receiptViewWidth=390.0f;
    }
    CGFloat receiptViewX=(self.frame.size.width-receiptViewWidth)*0.5;
    CGFloat receiptViewY=1;
    CGFloat receiptViewH=kReceiptViewHeight;
    _receiptView.frame=CGRectMake(receiptViewX, receiptViewY, receiptViewWidth, receiptViewH);
    _backgroundImageView.frame=CGRectMake(receiptViewX-1, receiptViewY-1, receiptViewWidth+2,kReceiptViewHeight+2);
    
    //头像
    CGFloat iconImageViewX=kMargin;
    CGFloat iconImageViewY=kMargin;
    _iconImageView.frame=CGRectMake(iconImageViewX, iconImageViewY,kIconImageViewWidth,kIconImageViewHeight);
    
    //公司名称
    CGFloat companyNameLabelX=CGRectGetMaxX(_iconImageView.frame)+kMargin;
    CGFloat companyNameLabelY=kMargin*1.5;
    CGFloat companyNameLabelWidth=100;
    CGFloat companyNameLabelHeight=20;
    _companyNameLabel.frame=CGRectMake(companyNameLabelX, companyNameLabelY, companyNameLabelWidth, companyNameLabelHeight);
    
    //薪资
    CGFloat totalSalaryLabelX=companyNameLabelX;
    CGFloat totalSalaryLabelY=CGRectGetMaxY(_companyNameLabel.frame)+kMargin;
    CGFloat totalSalaryLabelWidth=100;
    CGFloat totalSalaryLabelHeight=20;
    _totalSalaryLabel.frame=CGRectMake(totalSalaryLabelX,totalSalaryLabelY, totalSalaryLabelWidth, totalSalaryLabelHeight);
    
    //工作日期
    CGFloat workDateLabelX=CGRectGetMaxX(_totalSalaryLabel.frame)+kMargin;
    CGFloat workDateLabelY=totalSalaryLabelY;
    CGFloat workDateLabelWidth=120;
    CGFloat workDateLabelHeight=20;
    _workDateLabel.frame=CGRectMake(workDateLabelX, workDateLabelY, workDateLabelWidth, workDateLabelHeight);
    
    //换行
    //工作类型
    CGFloat workTypeLabelX=0;
    CGFloat workTypeLabelY=CGRectGetMaxY(_iconImageView.frame)+kMargin;
    _workTypeLabel.frame=CGRectMake(workTypeLabelX, workTypeLabelY, bottomItemWidth,kBottomItemHeight);
    
    //工作标题
    CGFloat workSalaryLabelX=CGRectGetMaxX(_workTypeLabel.frame);
    CGFloat workSalaryLabelY=workTypeLabelY;
    _workSalaryLabel.frame=CGRectMake(workSalaryLabelX, workSalaryLabelY, bottomItemWidth,kBottomItemHeight);
    //打卡
    CGFloat buttonX=CGRectGetMaxX(_workSalaryLabel.frame);
    CGFloat buttonY=workTypeLabelY;
    _button.frame=CGRectMake(buttonX, buttonY,bottomItemWidth, kBottomItemHeight);
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.y+=kMargin;
    [super setFrame:frame];
}

-(void) setReceipt:(Receipt *)receipt
{
    _receipt=receipt;
    //数据
     [_iconImageView sd_setImageWithURL:[NSURL URLWithString:receipt.job.company.imageUrlStr] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    _companyNameLabel.text=receipt.job.company.companyName;
    _totalSalaryLabel.text=[NSString stringWithFormat:@"￥%ld",receipt.price];
    _workDateLabel.text=receipt.job.workTime;
    
    _workTypeLabel.text=receipt.job.name;
    _workSalaryLabel.text=[NSString stringWithFormat:@"￥%ld/天",receipt.job.salary];
    if (receipt.isPayed)
    {
        [_button setTitle:@"已收款" forState:UIControlStateNormal];
    }
    else
    {
        [_button setTitle:@"待收款" forState:UIControlStateNormal];
    }
    
}

@end
