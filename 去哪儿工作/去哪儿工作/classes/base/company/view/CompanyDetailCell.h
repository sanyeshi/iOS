//
//  CompanyDetailHeaderView.h
//  parttime
//
//  Created by 孙硕磊 on 4/5/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeparatorCell.h"

@class CompanyDetaiCellFrame;
@class Company;


@interface CompanyDetailCell: SeparatorCell
@property(nonatomic,strong) UIImageView * companyImageView;
@property(nonatomic,strong) UILabel     * companyNameLabel;
@property(nonatomic,strong) UILabel     * authenticationLabel;

//详情
@property(nonatomic,strong) UILabel     * companyAddressLabel;
@property(nonatomic,strong) UILabel     * contactNameLabel;
@property(nonatomic,strong) UILabel     * cellphoneLabel;
@property(nonatomic,strong) UILabel     * authenticationTypeLabel;
@property(nonatomic,strong) UILabel     * companyInfoLabel;

//模型
-(void) setDetailFrame:(CompanyDetaiCellFrame *) detailFrame;
- (void)setCompany:(Company *)company;
@end
