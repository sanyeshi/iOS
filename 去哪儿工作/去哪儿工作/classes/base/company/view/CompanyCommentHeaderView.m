//
//  JobCommentHeaderView.m
//  parttime
//
//  Created by 孙硕磊 on 4/5/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CompanyCommentHeaderView.h"
#define kMargin 10
@interface  CompanyCommentHeaderView()
{
    UIView * _separator;
}
@end

@implementation CompanyCommentHeaderView
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor=GlobalBackgroundColor;
        [self createSubViews];
    }
    return self;
}

-(void) createSubViews
{
    self.titleLabel=[[UILabel alloc] init];
    _titleLabel.text=@"公司评价";
    _titleLabel.font=GlobalBoldFont;
    _titleLabel.textColor=GlobalBlackTextColor;
    [self addSubview:_titleLabel];
    

    _separator=[[UIView alloc] init];
    _separator.backgroundColor=GlobalSeparatorColor;
    [self addSubview:_separator];
}

-(void) layoutSubviews
{
    CGFloat titleLabelX=kMargin;
    CGFloat titleLabelY=0;
    CGFloat titleLabelWidth=80;
    CGFloat titleLabelHeight=kCompanyCommentHeaderViewHeight;
    _titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelWidth, titleLabelHeight);
    
    _separator.frame=CGRectMake(0, kCompanyCommentHeaderViewHeight-1, self.frame.size.width,GlobalSeparatorHeight);
}
@end
