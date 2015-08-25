//
//  CompanyDetaiCellFrame.m
//  parttime
//
//  Created by 孙硕磊 on 4/17/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CompanyDetaiCellFrame.h"
#import "Company.h"
#import <UIKit/UIKit.h>


#define kMargin   10
#define kMargin_2 5
#define kCompanyDetailCellHeaderViewHeight 230

@implementation CompanyDetaiCellFrame
- (instancetype)initWithScreenWidth:(CGFloat) screenWidth company:(Company *) company
{
    self = [super init];
    if (self)
    {
        [self calculateFrameWithScreenWidth:screenWidth company:company];
    }
    return self;
}


-(CGFloat) getCompanyDetailCellHeight
{
    return CGRectGetMaxY(_detailViewFrame)+GlobalSeparatorHeight;
}

-(void) calculateFrameWithScreenWidth:(CGFloat) width company:(Company *) company
{
    //提示(公司概况)
    CGFloat tipLabelX=kMargin;
    CGFloat tipLabelY=0;
    _detailTipLabelFrame=CGRectMake(tipLabelX, tipLabelY, width, 20);
    
    tipLabelX=kMargin;
    tipLabelY=CGRectGetMaxY(_detailTipLabelFrame)+kMargin;
    CGFloat tipLabelWidth=60;
    CGFloat tipLabelHeight=20;
    
    CGFloat labelX=tipLabelX+tipLabelWidth+kMargin;
    CGFloat labelY=tipLabelY;
    CGFloat labelWidth=width-labelX-kMargin;
    CGFloat labelHeight=tipLabelHeight;
    //公司地址
    _companyAddressTipLabelFrame=CGRectMake(tipLabelX,tipLabelY,tipLabelWidth, tipLabelHeight);
    _companyAddressLabelFrame=CGRectMake(labelX, labelY, labelWidth, labelHeight);
    //联系人
    tipLabelY+=tipLabelHeight+kMargin_2;
    labelY=tipLabelY;
    _contactNameTipLabelFrame=CGRectMake(tipLabelX,tipLabelY,tipLabelWidth, tipLabelHeight);
    _contactNameLabelFrame=CGRectMake(labelX, labelY, labelWidth, labelHeight);
    //联系电话
    tipLabelY+=tipLabelHeight+kMargin_2;
    labelY=tipLabelY;
    _cellphoneTipLabelFrame=CGRectMake(tipLabelX,tipLabelY,tipLabelWidth, tipLabelHeight);
    _cellphoneLabelFrame=CGRectMake(labelX, labelY, labelWidth, labelHeight);
    //认证类型
    tipLabelY+=tipLabelHeight+kMargin_2;
    labelY=tipLabelY;
    _authenticationTypeTipLabelFrame=CGRectMake(tipLabelX,tipLabelY,tipLabelWidth, tipLabelHeight);
    _authenticationTypeLabelFrame=CGRectMake(labelX, labelY, labelWidth, labelHeight);
    //公司简介
    tipLabelY+=tipLabelHeight+kMargin;
    labelY=tipLabelY;
    CGRect bound=[company.info boundingRectWithSize:CGSizeMake(labelWidth,INT64_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName :GlobalFont} context:nil];
    _companyInfoTipLabelFrame=CGRectMake(tipLabelX,tipLabelY,tipLabelWidth, tipLabelHeight);
    _companyInfoLabelFrame=CGRectMake(labelX, labelY, labelWidth,bound.size.height);
    
    _detailViewFrame=CGRectMake(0,kCompanyDetailCellHeaderViewHeight, width,CGRectGetMaxY(_companyInfoLabelFrame)+kMargin);

}
@end
