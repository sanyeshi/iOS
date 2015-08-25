//
//  SchoolCell.m
//  parttime
//
//  Created by 孙硕磊 on 4/24/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ExperienceCell.h"
#import "Experience.h"

#define kMargin 10
#define kMargin_2 5

@implementation ExperiencelCell

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
    //学校
    self.titleLabel=[self createLabelWithFont:GlobalBoldFont];
    [self.contentView addSubview:_titleLabel];
    
    //专业
    self.detailLabel=[self createLabelWithFont:GlobalSmallFont];
    [self.contentView addSubview:_detailLabel];
    
    //时间
    self.durationLabel=[self createLabelWithFont:GlobalSmallFont];
    _durationLabel.textAlignment=NSTextAlignmentRight;
    [self.contentView addSubview:_durationLabel];
    
}

-(UILabel *) createLabelWithFont:(UIFont *) font
{
    UILabel * label=[[UILabel alloc] init];
    label.font=font;
    label.textColor=GlobalLightBlackTextColor;
    return label;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width=self.frame.size.width;
    
    CGFloat titleLabelX=kMargin;
    CGFloat titleLabelY=kMargin_2;
    CGFloat titleLabelW=width-titleLabelX;
    CGFloat titleLabelH=20;
    _titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    
    CGSize  size=[_durationLabel.text sizeWithAttributes:@{ NSFontAttributeName :GlobalFont}];
    //时间
    CGFloat durationLabelW=size.width;
    CGFloat durationLabelH=titleLabelH;
    CGFloat durationLabelX=width-durationLabelW-kMargin;
    CGFloat durationLabelY=CGRectGetMaxY(_titleLabel.frame)+kMargin_2;
    _durationLabel.frame=CGRectMake(durationLabelX, durationLabelY, durationLabelW, durationLabelH);
    
    
    //详情
    CGFloat detailLabelX=titleLabelX;
    CGFloat detailLabelY=CGRectGetMaxY(_titleLabel.frame)+kMargin_2;
    CGFloat detailLabelW=durationLabelX-kMargin-detailLabelX;
    CGFloat detailLabelH=titleLabelH;
    _detailLabel.frame=CGRectMake(detailLabelX, detailLabelY,detailLabelW, detailLabelH);
}

-(void) setExperience:(Experience *)experience
{
    _experience=experience;
    _titleLabel.text=experience.title;
    _detailLabel.text=experience.detail;
    _durationLabel.text=[NSString stringWithFormat:@"时间:%@-%@",experience.startTime, experience.endTime];
}
@end
