//
//  SeparatorCell.m
//  parttime
//
//  Created by 孙硕磊 on 4/5/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "SeparatorCell.h"
@interface SeparatorCell ()
{
    UIView * _separatorLine;
}
@end

@implementation SeparatorCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIView * selectedBackgroundView=[[UIView alloc] init];
        selectedBackgroundView.backgroundColor=GlobalCellSelecedColor;
        self.selectedBackgroundView=selectedBackgroundView;
        
        _separatorLine=[[UIView alloc] init];
        _separatorLine.backgroundColor=GlobalSeparatorColor;
        [self.contentView addSubview:_separatorLine];
    }
    return self;
}

/*
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context,[GlobalLineCorlor CGColor]);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height-kSeparatorHeight, rect.size.width, kSeparatorHeight));
}*/

-(void) layoutSubviews
{
    [super layoutSubviews];
    CGFloat separatorLineWidth=self.frame.size.width;
    CGFloat separatorLineX=0;
    CGFloat separatorLineY=self.frame.size.height-GlobalSeparatorHeight;
    _separatorLine.frame=CGRectMake(separatorLineX, separatorLineY, separatorLineWidth,GlobalSeparatorHeight);
}


@end
