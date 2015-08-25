//
//  Account.m
//  parttime
//
//  Created by 孙硕磊 on 5/17/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "AccountCell.h"

#define kMargin 10

@implementation AccountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIView * selectedBackgroundView=[[UIView alloc] init];
        selectedBackgroundView.backgroundColor=GlobalCellSelecedColor;
        self.selectedBackgroundView=selectedBackgroundView;
        [self  createSubViews];
    }
    return self;
}


-(void) setRightView:(UIView *)rightView
{
    [_rightView removeFromSuperview];
    _rightView=rightView;
    [self.contentView addSubview:_rightView];
}
-(void) createSubViews
{
    self.titleLabel=[[UILabel alloc] init];
    _titleLabel.font=GlobalFont;
    _titleLabel.textColor=GlobalLightBlackTextColor;
    [self.contentView addSubview:_titleLabel];
}


-(void) layoutSubviews
{
    [super layoutSubviews];
    CGSize textSize = [_titleLabel.text sizeWithAttributes:@{ NSFontAttributeName:GlobalFont}];
    _titleLabel.frame=CGRectMake(kMargin, 0, textSize.width, self.frame.size.height);
}
@end
