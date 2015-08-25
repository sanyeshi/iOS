//
//  CompanySimpleCell.m
//  parttime
//
//  Created by 孙硕磊 on 4/18/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CompanySimpleCell.h"
#define kMargin 10
@implementation CompanySimpleCell
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
    self.titleLabel=[[UILabel alloc] init];
    _titleLabel.textColor=GlobalBlackTextColor;
    _titleLabel.font=GlobalBoldFont;
    [self.contentView addSubview:_titleLabel];
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.frame=CGRectMake(kMargin, 0, self.frame.size.width, self.frame.size.height-GlobalSeparatorHeight);
}
@end
