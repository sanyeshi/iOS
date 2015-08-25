//
//  CompanyDetaiCellFrame.h
//  parttime
//
//  Created by 孙硕磊 on 4/17/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@class Company;
@interface CompanyDetaiCellFrame : NSObject

@property(nonatomic,assign,readonly) CGRect detailViewFrame;
@property(nonatomic,assign,readonly) CGRect detailTipLabelFrame;

@property(nonatomic,assign,readonly) CGRect companyAddressTipLabelFrame;
@property(nonatomic,assign,readonly) CGRect companyAddressLabelFrame;

@property(nonatomic,assign,readonly) CGRect contactNameTipLabelFrame;
@property(nonatomic,assign,readonly) CGRect contactNameLabelFrame;

@property(nonatomic,assign,readonly) CGRect cellphoneTipLabelFrame;
@property(nonatomic,assign,readonly) CGRect cellphoneLabelFrame;


@property(nonatomic,assign,readonly) CGRect  authenticationTypeTipLabelFrame;
@property(nonatomic,assign,readonly) CGRect  authenticationTypeLabelFrame;

@property(nonatomic,assign,readonly) CGRect  companyInfoTipLabelFrame;
@property(nonatomic,assign,readonly) CGRect  companyInfoLabelFrame;

- (instancetype)initWithScreenWidth:(CGFloat) ScreenWidt company:(Company *) company;
-(CGFloat) getCompanyDetailCellHeight;
@end
