//
//  JobCell.h
//  parttime
//
//  Created by 孙硕磊 on 3/28/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeparatorCell.h"

#define kJobCellHeight       60

@class Job;
@interface JobCell : SeparatorCell

    //头部控件
    @property(nonatomic,strong) UIButton    *jobTypeButton;
    @property(nonatomic,strong) UILabel     *jobTitleLabel;
    @property(nonatomic,strong) UILabel     *jobAddressLabel;
    @property(nonatomic,strong) UILabel     *jobDateLabel;
    @property(nonatomic,strong) UILabel     *jobSalaryLabel;
    //数据
    @property(nonatomic,strong) Job *job;
@end
