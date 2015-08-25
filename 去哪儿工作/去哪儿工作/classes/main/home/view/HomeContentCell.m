//
//  HomeContentCell.m
//  parttime
//
//  Created by 孙硕磊 on 4/7/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//
#import "HomeContentCell.h"
#import "HomeContent.h"
#import "UIImageView+WebCache.h"
#import "Company.h"

#define kMargin 5

@implementation HomeContentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self createSubViews];
    }
    return self;
}

-(void) setModel:(HomeContent *)model
{
    if (model)
    {
      //  [_iconImageView sd_setImageWithURL:[[NSURL alloc] initWithString:model.imageUrlStr] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
         #warning 测试数据
        _iconImageView.image=[UIImage imageNamed:@"icon.jpg"];
        _contentTitleLabel.text=model.title;
        _contentLabel.text=model.company.info;
    }

}

-(void) createSubViews
{
    //头像
    self.iconImageView=[[UIImageView alloc] init];
    _iconImageView.layer.cornerRadius=25.0f;
    _iconImageView.clipsToBounds=YES;
    _iconImageView.contentMode=UIViewContentModeScaleAspectFit;
   // _iconImageView.contentMode=UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_iconImageView];
    
    //标题
    self.contentTitleLabel=[[UILabel alloc] init];
    _contentTitleLabel.font=GlobalBoldFont;
    _contentTitleLabel.textColor=GlobalLightBlackTextColor;
    [self.contentView addSubview:_contentTitleLabel];
    

    //内容
    self.contentLabel=[[UILabel alloc] init];
    _contentLabel.font=GlobalSmallFont;
    _contentLabel.textColor=GlobalBackgroundTextColor;
    [self.contentView addSubview:_contentLabel];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //头像
    CGFloat iconImageViewX=kMargin;
    CGFloat iconImageViewY=kMargin;
    CGFloat iconImageViewWidth=50;
    CGFloat iconImageViewHeight=50;
    _iconImageView.frame=CGRectMake(iconImageViewX, iconImageViewY, iconImageViewWidth, iconImageViewHeight);
    
    //标题
    CGFloat contentTitleLabelX=CGRectGetMaxX(_iconImageView.frame)+kMargin*2;
    CGFloat contentTitleLabelY=kMargin;
    CGFloat contentTitleLabelWidth=self.frame.size.width-contentTitleLabelX;
    CGFloat contentTitleLabelHeight=20;
    _contentTitleLabel.frame=CGRectMake(contentTitleLabelX, contentTitleLabelY, contentTitleLabelWidth, contentTitleLabelHeight);

    
    //内容
    CGFloat contentLabelX=contentTitleLabelX;
    CGFloat contentLabelY=CGRectGetMaxY(_contentTitleLabel.frame)+kMargin;
    CGFloat contentLabelWidth=self.frame.size.width-contentLabelX;
    CGFloat contentLabelHeight=20;
    _contentLabel.frame=CGRectMake(contentLabelX,contentLabelY,contentLabelWidth,contentLabelHeight);
    
}
@end
