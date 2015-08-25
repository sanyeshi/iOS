//
//  HomeContentCell.h
//  parttime
//
//  Created by 孙硕磊 on 4/7/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "SeparatorCell.h"
@class HomeContentCellModel;

#define kHomeContentCellHeight 60
@interface HomeContentCell : SeparatorCell
@property(nonatomic,strong) UIImageView          *iconImageView;
@property(nonatomic,strong) UILabel              *contentTitleLabel;
@property(nonatomic,strong) UILabel              *contentLabel;

@property(nonatomic,strong) HomeContentCellModel *model;
@end
