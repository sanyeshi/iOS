//
//  PunchcardCell.m
//  parttime
//
//  Created by 孙硕磊 on 4/5/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CardCell.h"
#import "Card.h"
#import "Job.h"
#import "Company.h"
#import "UIImageView+WebCache.h"



#define kMargin   10
#define kIconImageViewWidth  60
#define kIconImageViewHeight 60
#define kBottomItemHeight    60
#define kPunchCardViewHeight 140


@interface CardCell ()
{
    UIView      * _punchcardView;
    UIImageView * _backgroundImageView;
}
@end

@implementation CardCell

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

    
    _punchcardView=[[UIView alloc] init];
    _punchcardView.backgroundColor=GlobalBackgroundColor;
    [self.contentView addSubview:_punchcardView];
    
    //头像
    self.iconImageView=[[UIImageView alloc] init];
    _iconImageView.layer.cornerRadius=kIconImageViewHeight*0.5;
    _iconImageView.clipsToBounds=YES;
    _iconImageView.contentMode=UIViewContentModeScaleAspectFit;
    [_punchcardView addSubview:_iconImageView];
    
    //联系人姓名
    self.contactNameLabel=[self createLabelWithTextColor:GlobalBlackTextColor textFont:GlobalBigFont];
    
    //联系电话
    self.contactCellphoneLabel=[self createLabel];
    
    //工作日期
    self.workDateLabel=[self createLabel];
    
    //工作类型
    self.workTypeLabel=[self createLabelWithTextColor:GlobalWhiteTextColor textFont:GlobalBigFont];
    _workTypeLabel.textAlignment=NSTextAlignmentCenter;
    _workTypeLabel.backgroundColor=RGBColor(93, 131, 167);
    //工作标题
    self.workTitleLabel=[self createLabelWithTextColor:GlobalWhiteTextColor textFont:GlobalBigFont];
    _workTitleLabel.textAlignment=NSTextAlignmentCenter;
    _workTitleLabel.backgroundColor=RGBColor(160, 197, 103);
    
    //打卡
    self.punchcardButton=[[UIButton alloc] init];
    _punchcardButton.userInteractionEnabled=NO;
    _punchcardButton.enabled=NO;
    _punchcardButton.backgroundColor=RGBColor(253, 132, 133);
    _punchcardButton.titleLabel.font=GlobalBigFont;
    [_punchcardButton setTitleColor:GlobalWhiteTextColor forState:UIControlStateNormal];
    //[_punchcardButton addTarget:self action:@selector(didPunchCard:) forControlEvents:UIControlEventTouchDown];
    [_punchcardView addSubview:_punchcardButton];
    
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
    [_punchcardView addSubview:label];
    return label;
}

-(void) didPunchCard:(UIButton *) button
{
    [_delegate cardCell:self didPunchCardAtIndex:_index];
}
//布局子视图
- (void)layoutSubviews
{
    CGFloat bottomItemWidth=100.0f;
    CGFloat punchcardViewWidth=300.0f;
    if(iPhone5)
    {
        bottomItemWidth=100.0f;
        punchcardViewWidth=300.0f;
    }
    else if (iPhone6)
    {
        bottomItemWidth=120.0f;
        punchcardViewWidth=360.0f;
    }
    else if (iPhone6Plus)
    {
        bottomItemWidth=130.0f;
        punchcardViewWidth=390.0f;
    }
    CGFloat punchcardViewX=(self.frame.size.width-punchcardViewWidth)*0.5;
    CGFloat punchcardViewY=1;
    CGFloat punchcardViewH=kPunchCardViewHeight;
    _punchcardView.frame=CGRectMake(punchcardViewX, punchcardViewY, punchcardViewWidth, punchcardViewH);
    
    _backgroundImageView.frame=CGRectMake(punchcardViewX-1, punchcardViewY-1, punchcardViewWidth+2,kPunchCardViewHeight+2);
    /*
       布局方式:
       kMargin
       头像  联系人
       头像  联系人电话    工作日期
       kMargin
       工作类型 工作标题    打卡
     */
    
    //头像
    CGFloat iconImageViewX=kMargin;
    CGFloat iconImageViewY=kMargin;
    _iconImageView.frame=CGRectMake(iconImageViewX, iconImageViewY,kIconImageViewWidth,kIconImageViewHeight);
    
    //联系人姓名
    CGFloat contactNameLabelX=CGRectGetMaxX(_iconImageView.frame)+kMargin;
    CGFloat contactNameLabelY=kMargin*1.5;
    CGFloat contatcNameLabelWidth=100;
    CGFloat contactNameLabelHeight=20;
    _contactNameLabel.frame=CGRectMake(contactNameLabelX, contactNameLabelY, contatcNameLabelWidth, contactNameLabelHeight);
    
    //换行
    //电话图片
    
    //联系电话
    CGFloat contactCellphoneLabelX=contactNameLabelX;
    CGFloat contactCellphoneLabelY=CGRectGetMaxY(_contactNameLabel.frame)+kMargin;
    CGFloat contatcCellphoneLabelWidth=100;
    CGFloat contactCellphoneLabelHeight=20;
    _contactCellphoneLabel.frame=CGRectMake(contactCellphoneLabelX, contactCellphoneLabelY, contatcCellphoneLabelWidth, contactCellphoneLabelHeight);
    
    //工作日期
    CGFloat workDateLabelX=CGRectGetMaxX(_contactCellphoneLabel.frame)+kMargin;
    CGFloat workDateLabelY=contactCellphoneLabelY;
    CGFloat workDateLabelWidth=120;
    CGFloat workDateLabelHeight=20;
    _workDateLabel.frame=CGRectMake(workDateLabelX, workDateLabelY, workDateLabelWidth, workDateLabelHeight);
    
    //换行
    //工作类型
    CGFloat workTypeLabelX=0;
    CGFloat workTypeLabelY=CGRectGetMaxY(_iconImageView.frame)+kMargin;
    _workTypeLabel.frame=CGRectMake(workTypeLabelX, workTypeLabelY, bottomItemWidth,kBottomItemHeight);
    //工作标题
    CGFloat workTitleLabelX=CGRectGetMaxX(_workTypeLabel.frame);
    CGFloat workTiteLabelY=workTypeLabelY;
    _workTitleLabel.frame=CGRectMake(workTitleLabelX, workTiteLabelY, bottomItemWidth,kBottomItemHeight);
    //打卡
    CGFloat punchcardButtonX=CGRectGetMaxX(_workTitleLabel.frame);
    CGFloat punchcardButtonY=workTypeLabelY;
    _punchcardButton.frame=CGRectMake(punchcardButtonX, punchcardButtonY,bottomItemWidth, kBottomItemHeight);
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.y+=kMargin;
    [super setFrame:frame];
}


-(void) setCard:(Card *)card
{
    _card=card;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:card.job.company.imageUrlStr] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    _contactNameLabel.text=card.job.contactName;
    _contactCellphoneLabel.text=card.job.contactPhone;
    _workDateLabel.text=card.job.workTime;
    _workTypeLabel.text=card.job.type;
    _workTitleLabel.text=card.job.title;
    if (card.isRegisted)
    {
        [_punchcardButton setTitle:@"已打卡" forState:UIControlStateNormal];
    }
    else
    {
        [_punchcardButton setTitle:@"待打卡" forState:UIControlStateNormal];
    }
    
    
}

@end
