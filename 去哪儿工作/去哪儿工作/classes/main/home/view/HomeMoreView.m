//
//  HomeMoreView.m
//  parttime
//
//  Created by 孙硕磊 on 3/29/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "HomeMoreView.h"

#define kMargin          6
#define kSeparatorHeight 1
#define kItemWidth       240
#define kItemHeight      30
#define kContentViewWidth  240
#define kContentViewHeight 100

@interface HomeMoreView ()
{
    UIView        *   _contentView;
    UIImageView   *   _backgroundImageView;
}
@end
@implementation HomeMoreView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.hidden=YES;
    }
    return self;
}
/*
   点击按钮
 */
-(void) click:(UIButton *) btn
{
    [_delegate homeMoreView:self didSelectedItemIndex:btn.tag];
}

-(void) createButtonWithTitle:(NSString *) title  withImageName:(NSString *) imageName withTag:(NSInteger) tag
{
    UIButton * btn=[[UIButton alloc] init];
    btn.tag=tag;
    btn.titleLabel.font=GlobalFont;
    [btn setTitleColor:GlobalLightBlackTextColor forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -150, 0, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -140, 0, 0)];
    btn.frame=CGRectMake(0, tag*(kItemHeight+kSeparatorHeight)+kMargin, kItemWidth, kItemHeight);
    [_contentView addSubview:btn];
}

-(void) createSeparatorWithFrame:(CGRect) frame
{
    UIView * separator=[[UIView alloc] init];
    separator.backgroundColor=GlobalSeparatorColor;
    separator.frame=frame;
    [_contentView addSubview:separator];
}
-(void) createSubViews
{
    
    CGFloat moreViewX=0;
    CGFloat moreViewY=64+2;
    CGFloat moreViewW=[[UIScreen mainScreen] bounds].size.width;
    CGFloat moreViewH=[[UIScreen mainScreen] bounds].size.height-moreViewX;
    self.frame=CGRectMake(moreViewX, moreViewY, moreViewW, moreViewH);
    self.backgroundColor=[UIColor clearColor];
    
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    
    CGFloat contentViewW=kContentViewWidth;
    CGFloat contentViewH=kContentViewHeight;
    CGFloat contentViewX=moreViewW-contentViewW;
    CGFloat contentViewY=0;
    
    _contentView=[[UIView alloc] init];
    _contentView.frame=CGRectMake(contentViewX, contentViewY, contentViewW, contentViewH);
    _contentView.backgroundColor=[UIColor clearColor];
    _contentView.alpha=0.0;
    _contentView.hidden=YES;
    _contentView.clipsToBounds=YES;
    [self addSubview:_contentView];
    
    
    //背景图片
    UIImage * backgroundImage=[UIImage imageNamed:@"home_more_bg.png"];
    backgroundImage=[backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(20,1,5,50) resizingMode:UIImageResizingModeStretch];
    _backgroundImageView=[[UIImageView alloc] init];
    _backgroundImageView.image=backgroundImage;
    _backgroundImageView.frame=_contentView.bounds;
    [_contentView addSubview:_backgroundImageView];

    //每行高30
    //实习
    [self createButtonWithTitle:@"找找兼职" withImageName:@"home_more_intern.png" withTag:0];
    [self createSeparatorWithFrame:CGRectMake(0,kItemHeight+kSeparatorHeight+kMargin,kItemWidth,kSeparatorHeight)];
    //名企
    [self createButtonWithTitle:@"名企招聘" withImageName:@"home_more_company.png" withTag:1];
    [self createSeparatorWithFrame:CGRectMake(0,(kItemHeight+kSeparatorHeight)*2+kMargin,kItemWidth,kSeparatorHeight)];
    //我的职位
    [self createButtonWithTitle:@"我的职位" withImageName:@"home_more_job.png" withTag:2];
    
}

-(void) tap:(UITapGestureRecognizer *) tapGestureRecognizer
{
    [self hideWithAnimation];
}

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}


-(void) show
{
    if (_contentView==nil)
    {
        [self createSubViews];
    }
    self.hidden=NO;
    _contentView.hidden=NO;
    [UIView animateWithDuration:0.3f animations:^
    {
       _contentView.alpha=1.0f;
    }];
}

-(void) hideWithAnimation
{
    [UIView animateWithDuration:0.3f animations:^
     {
         _contentView.alpha=0.0f;
     }
     completion:^(BOOL finished)
     {
         _contentView.hidden=YES;
         self.hidden=YES;
     }];
}

-(void) hide
{
    _contentView.hidden=YES;
    self.hidden=YES;
}
@end
