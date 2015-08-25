//
//  InfoCell.m
//  parttime
//
//  Created by 孙硕磊 on 3/28/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "NewsImageCell.h"

#define kMargin 10

@interface NewsImageCell ()
{
     UIView * _separatorLine;
}
@end
@implementation NewsImageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        [self createSubViews];
    }
    return self;
}

-(void) createSubViews
{
    
    //图片
    self.newsImageView=[[UIImageView alloc] init];
    [self.contentView addSubview:_newsImageView];
    
    //info
    self.newsTitleLabel=[[UILabel alloc] init];
    _newsTitleLabel.font=GlobalSmallFont;
    _newsTitleLabel.textColor=GlobalBackgroundTextColor;
    [self.contentView addSubview:_newsTitleLabel];
    //分割线
     _separatorLine=[[UIView alloc] init];
    _separatorLine.backgroundColor=GlobalSeparatorColor;
    [self.contentView addSubview:_separatorLine];
}

/*
   布局子视图
 */
-(void) layoutSubviews
{
    //图片
    CGFloat newsImageViewX=0;
    CGFloat newsImageViweY=0;
    CGFloat newsImageViewWidth=self.frame.size.width;
    CGFloat newsImageViewHeight=200;
    _newsImageView.frame=CGRectMake(newsImageViewX, newsImageViweY, newsImageViewWidth, newsImageViewHeight);
    
    //title
    CGFloat titleLabelWidth=self.frame.size.width;
    CGFloat titleLabelHeight=30;
    CGFloat titleLabelX=10;
    CGFloat titleLabelY=CGRectGetMaxY(_newsImageView.frame);
    _newsTitleLabel.frame=CGRectMake(titleLabelX, titleLabelY, titleLabelWidth, titleLabelHeight);
    
    //分割线
    CGFloat separatorLineWidth=self.frame.size.width;
    CGFloat separatorLineHeight=1;
    CGFloat separatorLineX=0;
    CGFloat separatorLineY=CGRectGetMaxY(_newsTitleLabel.frame);
    _separatorLine.frame=CGRectMake(separatorLineX, separatorLineY, separatorLineWidth, separatorLineHeight);

}


-(void) setFrame:(CGRect)frame
{
    frame.origin.x=kMargin;
    frame.size.width=frame.size.width-2*kMargin;
    [super setFrame:frame];
}

@end
