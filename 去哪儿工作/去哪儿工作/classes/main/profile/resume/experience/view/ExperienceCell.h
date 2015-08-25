//
//  SchoolCell.h
//  parttime
//
//  Created by 孙硕磊 on 4/24/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeparatorCell.h"
#define kExperienceCellHeight 60
@class Experience;
@interface ExperiencelCell : SeparatorCell
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *detailLabel;
@property(nonatomic,strong) UILabel *durationLabel;
//数据
@property(nonatomic,strong) Experience * experience;
@end
