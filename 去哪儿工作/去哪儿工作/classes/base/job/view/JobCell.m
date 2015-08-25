//
//  JobCell.m
//  parttime
//
//  Created by 孙硕磊 on 3/28/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//


#import "JobCell.h"
#import "Job.h"
#import "PositionCategory.h"

#define kMargin 5

@interface JobCell ()
{
    
}
@end

@implementation JobCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor=[UIColor whiteColor];
        [self createSubViews];
    }
    return self;
}

#pragma mark -创建子控件
-(void) createSubViews
{
    //工作类型
    self.jobTypeButton=[[UIButton alloc] init];
    _jobTypeButton.clipsToBounds=YES;
    _jobTypeButton.layer.cornerRadius=20.0f;
    _jobTypeButton.titleLabel.font=GlobalFont;
    [_jobTypeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_jobTypeButton];

    
    //工作标题
    self.jobTitleLabel=[[UILabel alloc] init];
    _jobTitleLabel.font=GlobalBoldFont;
    _jobTitleLabel.textColor=GlobalBlackTextColor;
    [self.contentView addSubview:_jobTitleLabel];
    
    //工作地点
    _jobAddressLabel=[self addLabelToView:self.contentView];
  
    //工作日期
    _jobDateLabel=[self addLabelToView:self.contentView];
    
    //薪资
    self.jobSalaryLabel=[self addLabelToView:self.contentView];
}

#pragma mark -设置子控件的位置和大小
-(void)setFrameSubViews
{
    /*
       布局:
       工作类型  工作标题 
                地点    时间   薪资
     
     */
    //工作类型图片
    CGFloat jobTypeButtonX=kMargin;
    CGFloat jobTypeButtonY=2*kMargin;
    CGFloat jobTypeButtonWidth=40;
    CGFloat jobTypeButtonHeight=40;
    _jobTypeButton.frame=CGRectMake(jobTypeButtonX, jobTypeButtonY, jobTypeButtonWidth, jobTypeButtonHeight);
    //工作标题
    CGFloat jobTitleLabelX=CGRectGetMaxX(_jobTypeButton.frame)+2*kMargin;
    CGFloat jobTitleLabelY=kMargin;
    CGFloat jobTitleLabelWidth=self.frame.size.width-jobTitleLabelX-kMargin;
    CGFloat jobTitleLabelHeight=20;
    _jobTitleLabel.frame=CGRectMake(jobTitleLabelX, jobTitleLabelY, jobTitleLabelWidth, jobTitleLabelHeight);
    
    CGFloat  labelX=jobTitleLabelX;
    CGFloat  labelY=CGRectGetMaxY(_jobTitleLabel.frame)+kMargin;
    CGFloat  labelWidth=(self.frame.size.width-jobTitleLabelX-3*kMargin)/3;
    CGFloat  labelHeight=20;
    //工作地点
    _jobAddressLabel.frame=CGRectMake(labelX,labelY,labelWidth,labelHeight);

    //工作日期
    labelX+=labelWidth+kMargin;
    _jobDateLabel.frame=CGRectMake(labelX,labelY,labelWidth,labelHeight);

    //薪资
    labelX+=labelWidth+kMargin;
    _jobSalaryLabel.frame=CGRectMake(labelX,labelY,labelWidth,labelHeight);
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted)
    {
          _jobTypeButton.backgroundColor=[self getBackgroundColor:_job.category.Id];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected)
    {
          _jobTypeButton.backgroundColor=[self getBackgroundColor:_job.category.Id];
    }
}

#pragma mark -创建一个UILabel对象并添加到指定的父视图
-(UILabel *) addLabelToView:(UIView *) view
{
    UILabel * label=[[UILabel alloc] init];
    label.font=GlobalSmallFont;
    label.textColor=GlobalLightBlackTextColor;
    label.textAlignment=NSTextAlignmentLeft;
    [view addSubview:label];
    return label;
}

#pragma mark -布局子视图
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setFrameSubViews];
    
}
-(UIColor *)getBackgroundColor:(NSUInteger) index
{
      NSArray * backgroundColors=@[RGBColor(152,195,54),RGBColor(41,166,74),RGBColor(225,199,63),RGBColor(99,184,165),RGBColor(187,159,119),RGBColor(217,121,45),RGBColor(177,165,203)];
    return backgroundColors[index%backgroundColors.count];
}
#pragma mark - 设置数据
-(void) setJob:(Job *) job
{
    _job=job;
    //工作类型
      _jobTypeButton.backgroundColor=[self getBackgroundColor:job.category.Id];
     [_jobTypeButton setTitle:[job.category.name substringToIndex:2]forState:UIControlStateNormal];
    //工作标题
     _jobTitleLabel.text=job.title;
    //工作地点
    _jobAddressLabel.text=job.address;
    //工作日期
    _jobDateLabel.text=job.workTime;
    //薪资
     _jobSalaryLabel.text=[NSString stringWithFormat:@"%lu元/天",job.salary];
}
@end
