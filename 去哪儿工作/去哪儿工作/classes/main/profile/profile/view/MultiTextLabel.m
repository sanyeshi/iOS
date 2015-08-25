//
//  MultiTextLabel.m
//  parttime
//
//  Created by 孙硕磊 on 3/27/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "MultiTextLabel.h"

@implementation MultiTextLabel
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
        UIColor * textColor=GlobalWhiteTextColor;
        UIFont  * titleFont=GlobalBigFont;
        UIFont  * subTitleFont=GlobalFont;
        self.titleLabel=[[UILabel alloc] init];
        _titleLabel.textColor=textColor;
        _titleLabel.font=titleFont;
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        self.subTitleLabel=[[UILabel alloc] init];
        _subTitleLabel.textColor=textColor;
        _subTitleLabel.font=subTitleFont;
        _subTitleLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_subTitleLabel];
        
    }
    return self;
}


-(void)layoutSubviews
{
    _titleLabel.frame=CGRectMake(0, 0, self.frame.size.width, kMultilTextLabelTitleLableHeight);
    _subTitleLabel.frame=CGRectMake(0, kMultilTextLabelTitleLableHeight+kMultiTextMargin, self.frame.size.width, kMultilTextLabelSubTitleLabelHeight);
    
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height=kMultilTextLabelHeight;
    [super setFrame:frame];
}
@end
