//
//  InternCell.m
//  parttime
//
//  Created by 孙硕磊 on 4/20/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "InternCell.h"
#import "Intern.h"
#import "PositionCategory.h"



#define kMargin 5

@implementation InternCell

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
    self.typeButton=[[UIButton alloc] init];
    _typeButton.clipsToBounds=YES;
    _typeButton.layer.cornerRadius=20.0f;
    _typeButton.titleLabel.font=GlobalFont;
    [_typeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.contentView addSubview:_typeButton];
    
    
    //工作标题
    self.titleLabel=[[UILabel alloc] init];
    _titleLabel.font=GlobalBoldFont;
    _titleLabel.textColor=GlobalBlackTextColor;
    [self.contentView addSubview:_titleLabel];
    
    //工作地点
    _addressLabel=[self addLabelToView:self.contentView];
    
    //工作日期
    _dateLabel=[self addLabelToView:self.contentView];
    
    //薪资
    self.salaryLabel=[self addLabelToView:self.contentView];
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
    CGFloat typeButtonX=kMargin;
    CGFloat typeButtonY=2*kMargin;
    CGFloat typeButtonWidth=40;
    CGFloat typeButtonHeight=40;
    _typeButton.frame=CGRectMake(typeButtonX, typeButtonY, typeButtonWidth, typeButtonHeight);
    //工作标题
    CGFloat titleLabelX=CGRectGetMaxX(_typeButton.frame)+2*kMargin;
    CGFloat titleLabelY=kMargin;
    CGFloat titleLabelWidth=self.frame.size.width-titleLabelX-kMargin;
    CGFloat titleLabelHeight=20;
    _titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelWidth, titleLabelHeight);
    
    CGFloat  labelX=titleLabelX;
    CGFloat  labelY=CGRectGetMaxY(_titleLabel.frame)+kMargin;
    CGFloat  labelWidth=(self.frame.size.width-titleLabelX-3*kMargin)/3;
    CGFloat  labelHeight=20;
    //工作地点
    _addressLabel.frame=CGRectMake(labelX,labelY,labelWidth,labelHeight);
    
    //工作日期
    labelX+=labelWidth+kMargin;
    _dateLabel.frame=CGRectMake(labelX,labelY,labelWidth,labelHeight);
    
    //薪资
    labelX+=labelWidth+kMargin;
    _salaryLabel.frame=CGRectMake(labelX,labelY,labelWidth,labelHeight);
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted)
    {
        _typeButton.backgroundColor=[self getBackgroundColor:_intern.category.Id];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected)
    {
        _typeButton.backgroundColor=[self getBackgroundColor:_intern.category.Id];
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
-(void) setIntern:(Intern *) intern
{
    _intern=intern;
    //工作类型
    _typeButton.backgroundColor=[self getBackgroundColor:intern.category.Id];
    [_typeButton setTitle:[intern.category.name substringToIndex:2]forState:UIControlStateNormal];
    //工作标题
    _titleLabel.text=intern.title;
    //工作地点
    _addressLabel.text=intern.address;
    //工作日期
    _dateLabel.text=intern.workTime;
    //薪资
    _salaryLabel.text=[NSString stringWithFormat:@"%lu元/天",intern.salary];
}

@end
