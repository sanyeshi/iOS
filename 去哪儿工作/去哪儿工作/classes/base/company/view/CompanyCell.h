//
//  CompanyCell.h
//  parttime
//
//  Created by 孙硕磊 on 4/20/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "SeparatorCell.h"
#define kCompanyCellHeight 60.0f
@class Company;
@interface CompanyCell : SeparatorCell
@property(nonatomic,strong) UIImageView *iconImageView;
@property(nonatomic,strong) UILabel     *titleLabel;
@property(nonatomic,strong) UILabel     *addressLabel;
-(void) setCompany:(Company *) company;
@end
