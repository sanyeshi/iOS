//
//  ELCAlbumCell.m
//  parttime
//
//  Created by 孙硕磊 on 4/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ELCAlbumCell.h"

#define kMargin 5
#define kAlbumCellLabelFont       [UIFont systemFontOfSize:12.0f]
#define kAlbumCellLabelTextColor  [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1.0]
#define kAlbumCellSeparatorColor  [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1.0]
#define kAlbumCellSeparatorHeight  0.5


@interface ELCAlbumCell ()
{
    UIView * _separator;
}
@end
@implementation ELCAlbumCell
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
    //头像
    self.iconImageView=[[UIImageView alloc] init];
    _iconImageView.clipsToBounds=YES;
    _iconImageView.contentMode=UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_iconImageView];
    
    //标题
    self.titleLabel=[[UILabel alloc] init];
    _titleLabel.font=kAlbumCellLabelFont;
    _titleLabel.textColor=kAlbumCellLabelTextColor;
    [self.contentView addSubview:_titleLabel];
    //分割线
    _separator=[[UIView alloc] init];
    _separator.backgroundColor=kAlbumCellSeparatorColor;
    [self.contentView addSubview:_separator];
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
    CGFloat titleLabelX=CGRectGetMaxX(_iconImageView.frame)+kMargin*2;
    CGFloat titleLabelY=kMargin;
    CGFloat titleLabelWidth=self.frame.size.width-titleLabelX;
    CGFloat titleLabelHeight=50;
    _titleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelWidth, titleLabelHeight);
    
    //分割线
    _separator.frame=CGRectMake(0, self.frame.size.height-kAlbumCellSeparatorHeight, self.frame.size.width, kAlbumCellSeparatorHeight);
}


@end
