//
//  ReceiptCell.h
//  parttime
//
//  Created by 孙硕磊 on 5/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kReceiptCellHeight 150

@class Receipt;

@interface ReceiptCell : UITableViewCell

@property(nonatomic,assign) NSInteger     index;
@property(nonatomic,strong) UIImageView   *iconImageView;
@property(nonatomic,strong) UILabel       *companyNameLabel;
@property(nonatomic,strong) UILabel       *totalSalaryLabel;
@property(nonatomic,strong) UILabel       *workDateLabel;

@property(nonatomic,strong) UILabel       *workTypeLabel;
@property(nonatomic,strong) UILabel       *workSalaryLabel;
@property(nonatomic,strong) UIButton      *button;

@property(nonatomic,strong) Receipt       *receipt;
@end
