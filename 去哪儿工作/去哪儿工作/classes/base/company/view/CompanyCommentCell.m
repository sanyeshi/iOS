//
//  JobCommentCell.m
//  parttime
//
//  Created by 孙硕磊 on 4/5/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CompanyCommentCell.h"
#import "CompanyComment.h"

#define kMargin 10
#define kMargin_2 5

@implementation CompanyCommentCell
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
    self.commenterNameLabel=[[UILabel alloc] init];
    _commenterNameLabel.textColor=GlobalLightBlackTextColor;
    _commenterNameLabel.font=GlobalSmallFont;
    [self.contentView addSubview:_commenterNameLabel];
    
    self.dateLabel=[[UILabel alloc] init];
    _dateLabel.textColor=GlobalLightBlackTextColor;
    _dateLabel.font=GlobalSmallFont;
    [self.contentView addSubview:_dateLabel];
    
    self.commentLabel=[[UILabel alloc] init];
    _commentLabel.textColor=GlobalBlackTextColor;
    _commentLabel.font=GlobalFont;
    [self.contentView addSubview:_commentLabel];
}

-(void) layoutSubviews
{
     [super layoutSubviews];
     CGSize size=[_commenterNameLabel.text sizeWithAttributes:@{ NSFontAttributeName:GlobalSmallFont}];
     CGFloat commenterNameLabelX=kMargin;
     CGFloat commenterNameLabelY=kMargin_2;
     _commenterNameLabel.frame=CGRectMake(commenterNameLabelX, commenterNameLabelY,size.width,size.height);
    
    CGFloat dateLabelX=CGRectGetMaxX(_commenterNameLabel.frame)+kMargin;
    CGFloat dateLabelY=commenterNameLabelY;
    CGFloat dateLabelW=self.frame.size.width-dateLabelX-kMargin;
    CGFloat dateLabelH=size.height;
    _dateLabel.frame=CGRectMake(dateLabelX,dateLabelY, dateLabelW, dateLabelH);
    
    CGFloat commentLabelX=commenterNameLabelX;
    CGFloat comentLabelY=CGRectGetMaxY(_commenterNameLabel.frame);
    _commentLabel.frame=CGRectMake(commentLabelX, comentLabelY, self.frame.size.width,self.frame.size.height-comentLabelY);
}

#pragma mark - 设置数据
-(void) setCompanyComment:(CompanyComment *) comment
{
    _commenterNameLabel.text=comment.name;
    _dateLabel.text=comment.postTime;
    _commentLabel.text=comment.word;
}
@end
