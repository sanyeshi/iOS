//
//  CompanyCell.m
//  parttime
//
//  Created by 孙硕磊 on 4/20/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CompanyCell.h"
#import "Company.h"
#import "UIImageView+WebCache.h"

#define kMargin 10
#define kMargin_2 5

@implementation CompanyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self createSubViews];
    }
    return self;
}

-(void) createSubViews
{
    //图片
    self.iconImageView=[[UIImageView alloc]init];
    _iconImageView.contentMode=UIViewContentModeScaleAspectFit;
    _iconImageView.layer.cornerRadius=25.0f;
    _iconImageView.clipsToBounds=YES;
    [self.contentView addSubview:_iconImageView];
    //标题
    self.titleLabel=[[UILabel alloc] init];
    _titleLabel.textColor=GlobalBlackTextColor;
    _titleLabel.font=GlobalBoldFont;
    [self.contentView addSubview:_titleLabel];
    
    //地址
    self.addressLabel=[[UILabel alloc] init];
    _addressLabel.textColor=GlobalLightBlackTextColor;
    _addressLabel.font=GlobalSmallFont;
    [self.contentView addSubview:_addressLabel];
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    CGFloat width=self.frame.size.width;
    
    //图片
    CGFloat iconImageViewX=kMargin_2;
    CGFloat iconImageViewY=kMargin_2;
    CGFloat iconImageViewWidth=50;
    CGFloat iconImageViewHeight=50;
    _iconImageView.frame=CGRectMake(iconImageViewX, iconImageViewY, iconImageViewWidth, iconImageViewHeight);
    
    //标题
    CGFloat titleLabelX=CGRectGetMaxX(_iconImageView.frame)+kMargin;
    CGFloat titleLabelY=kMargin;
    CGFloat titleLabelWidth=width-titleLabelX;
    CGFloat titleLabelHeight=20;
    _titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelWidth, titleLabelHeight);
    
    //地址
    CGFloat addressLabelX=titleLabelX;
    CGFloat addressLabelY=CGRectGetMaxY(_titleLabel.frame)+kMargin_2;
    CGFloat addressLabelWidth=titleLabelWidth;
    CGFloat addressLabelHeight=20;
    _addressLabel.frame=CGRectMake(addressLabelX,addressLabelY,addressLabelWidth,addressLabelHeight);

}
#pragma mark - 设置数据
-(void) setCompany:(Company *) company
{
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:company.imageUrlStr]];
    _titleLabel.text=company.companyName;
    _addressLabel.text=company.address;
}

@end
