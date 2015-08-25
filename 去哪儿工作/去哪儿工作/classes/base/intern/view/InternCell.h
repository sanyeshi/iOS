//
//  InternCell.h
//  parttime
//
//  Created by 孙硕磊 on 4/20/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "SeparatorCell.h"
#define kInterCellHeight 60

@class Intern;
@interface InternCell : SeparatorCell

//头部控件
@property(nonatomic,strong) UIButton    *typeButton;
@property(nonatomic,strong) UILabel     *titleLabel;
@property(nonatomic,strong) UILabel     *addressLabel;
@property(nonatomic,strong) UILabel     *dateLabel;
@property(nonatomic,strong) UILabel     *salaryLabel;

@property(nonatomic,strong) Intern *intern;

@end




