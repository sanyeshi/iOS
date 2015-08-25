//
//  ProfileHeaderView.m
//  parttime
//
//  Created by 孙硕磊 on 4/6/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "MultiTextLabel.h"
#import "ProfileHeaderView.h"

#define kIconWidth       60
#define kIconHeight      60
#define kNameLabelHeight 40
#define kFooterViewHeight 60


@interface ProfileHeaderView ()
{
    UIView * _footerView;
    UIView * _separator;
}

@end
@implementation ProfileHeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.contentMode=UIViewContentModeScaleAspectFill;
        self.autoresizesSubviews=YES;
        [self createSubViews];
    }
    return self;
}

-(void) createSubViews
{
    
    //1、iconImageView
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.layer.cornerRadius = kIconWidth*0.5;
    _iconImageView.layer.borderWidth=2;
    _iconImageView.layer.borderColor=[[UIColor whiteColor] CGColor];
    _iconImageView.clipsToBounds = YES;
    _iconImageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:_iconImageView];
    
    //2、nameLabel
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.textAlignment=NSTextAlignmentCenter;
    _nameLabel.textColor =GlobalWhiteTextColor;
    _nameLabel.font=GlobalBoldFont;
    _nameLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:_nameLabel];
    
    //3、底部视图
    [self createFooterViewFor:self];
}


-(void) createFooterViewFor:(UIView *)view
{
    
   //底部视图
    _footerView=[[UIView alloc] init];
    _footerView.backgroundColor=[UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:0.2f];
    [view addSubview:_footerView];
    
    
    //积分
    self.pointValueLabel=[[MultiTextLabel alloc] init];
    _pointValueLabel.tag=0;
    _pointValueLabel.titleLabel.text=@"积分";
    _pointValueLabel.subTitleLabel.text=@"0";
    [_footerView addSubview:_pointValueLabel];
    
   
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_pointValueLabel addGestureRecognizer:tap];
    

    //分割符
    _separator=[[UIView alloc] init];
    _separator.backgroundColor=GlobalSeparatorColor;
    [_footerView addSubview:_separator];
    
    //金额
    self.moneyLabel=[[MultiTextLabel alloc] init];
    _moneyLabel.tag=1;
    _moneyLabel.titleLabel.text=@"金库";
    _moneyLabel.subTitleLabel.text=@"￥0";
    [_footerView addSubview:_moneyLabel];
    
    tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_moneyLabel addGestureRecognizer:tap];

}

- (void)layoutSubviews
{
    CGFloat width=self.frame.size.width;
    CGFloat height=self.frame.size.height;
    //1、iconImageView
    CGFloat iconImageViewX=(width-kIconWidth)*0.5;
    CGFloat iconImageViewY=height-kFooterViewHeight-kNameLabelHeight-kIconHeight;
    CGFloat iconImageViewWidth=kIconWidth;
    CGFloat iconIamgeViewHeight=kIconHeight;
    _iconImageView.frame=CGRectMake(iconImageViewX,iconImageViewY,iconImageViewWidth,iconIamgeViewHeight);
    
    //2、 nameLabel
    CGFloat nameLabelX=0;
    CGFloat nameLabelY=height-kFooterViewHeight-kNameLabelHeight;
    CGFloat nameLabelWidth=self.frame.size.width;
    CGFloat nameLabelHeight=kNameLabelHeight;
    _nameLabel.frame=CGRectMake(nameLabelX,nameLabelY,nameLabelWidth,nameLabelHeight);
    
    [self layoutFooterViews];
    
}

-(void) layoutFooterViews
{
    CGFloat width=self.frame.size.width;
    CGFloat height=self.frame.size.height;
    //底部视图
    CGFloat  footerViewHeight=kFooterViewHeight;
    CGFloat  footerViewWidth=width;
    CGFloat  footerViewX=0;
    CGFloat  footerViewY=height-footerViewHeight;
    _footerView.frame=CGRectMake(footerViewX, footerViewY, footerViewWidth, footerViewHeight);
    
    //积分
    CGFloat pointValueLabelX=0.0f;
    CGFloat pointValueLabelY=13;
    CGFloat pointValueLabelWidth=width*0.5-1;
    CGFloat pointValueLabelHeight=kMultilTextLabelHeight;
    _pointValueLabel.frame=CGRectMake(pointValueLabelX, pointValueLabelY, pointValueLabelWidth,pointValueLabelHeight);
    
    //分割符
    CGFloat separatorX=pointValueLabelWidth;
    CGFloat separatorY=pointValueLabelY;
    CGFloat separatorWidth=1.0f;
    CGFloat separatorHeight=pointValueLabelHeight;
    _separator.frame=CGRectMake(separatorX, separatorY, separatorWidth, separatorHeight);

    //金额
    CGFloat moneyLabelX=separatorX+separatorWidth;
    CGFloat moneyLabelY=pointValueLabelY;
    CGFloat moneyLabelWidth=pointValueLabelWidth;
    CGFloat moneyLabelHeight=pointValueLabelHeight;
    _moneyLabel.frame=CGRectMake(moneyLabelX, moneyLabelY, moneyLabelWidth, moneyLabelHeight);
}

-(void) tap:(UITapGestureRecognizer *) tapGestureRecognizer
{
    if (_profileHeaderViewDelegate&&[_profileHeaderViewDelegate conformsToProtocol:@protocol(ProfileHeaderViewDelegate)])
    {
        [_profileHeaderViewDelegate profileHeaderView:self didSelectedAtIndex:tapGestureRecognizer.view.tag];
    }
}
@end
