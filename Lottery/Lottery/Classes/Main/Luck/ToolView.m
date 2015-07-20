//
//  ToolView.m
//  Lottery
//
//  Created by 孙硕磊 on 6/27/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ToolView.h"
#define  kToolViewWidth   180
#define  kToolViewHeight  82
@interface ToolView ()
{
    UIImageView * _imageView;
    UIButton    * _typeButton;
}
@end
@implementation ToolView

+(instancetype) toolView
{
   return [[ToolView alloc] init];
}


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setupSubviews];
    }
    return self;
}


-(void) setupSubviews
{
    self.bounds=CGRectMake(0, 0, kToolViewWidth, kToolViewHeight);
    
    _imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LuckyThreeButton"]];
    _imageView.contentMode=UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
    
    _typeButton=[[UIButton alloc] init];
    _typeButton.frame=CGRectMake(0, 32, 50, 50);
    _typeButton.titleEdgeInsets=UIEdgeInsetsMake(-3, 0, 0, 0);
    _typeButton.titleLabel.font=[UIFont systemFontOfSize:10.0f];
    [_typeButton setTitle:@"双色球" forState:UIControlStateNormal];
    [_typeButton setBackgroundImage:[UIImage imageNamed:@"LuckyLeftPressed"] forState:UIControlStateHighlighted];
    [self addSubview:_typeButton];
    
}


-(void) setFrame:(CGRect)frame
{
    frame.size=CGSizeMake(kToolViewWidth, kToolViewHeight);
    [super setFrame:frame];
}

-(void) setBounds:(CGRect)bounds
{
   bounds.size=CGSizeMake(kToolViewWidth, kToolViewHeight);
   [super setBounds:bounds];
}

@end
