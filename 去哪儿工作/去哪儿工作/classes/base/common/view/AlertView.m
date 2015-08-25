//
//  HttpErrorView.m
//  parttime
//
//  Created by 孙硕磊 on 4/18/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "AlertView.h"

#define kMaxWidth 300
#define kWidth 200
#define kHeight 40
#define kMargin 10

@interface AlertView ()
{
    UILabel * _titleLabel;
}
@end

@implementation AlertView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.bounds=CGRectMake(0, 0, kWidth, kHeight);
        self.layer.cornerRadius=5.0f;
        self.clipsToBounds=YES;
        self.backgroundColor=[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.6];
        [self createSubViews];
    }
    return self;
}
-(void) createSubViews
{
    _titleLabel=[[UILabel alloc] init];
    _titleLabel.font=GlobalFont;
    _titleLabel.textColor=[UIColor whiteColor];
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    _titleLabel.frame=self.bounds;
    [self addSubview:_titleLabel];
}

-(void) show
{
    CGSize titleSize = [_titleLabel.text boundingRectWithSize:CGSizeMake(kMaxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_titleLabel.font} context:nil].size;
    CGFloat width=titleSize.width+2*kMargin;
    if (width>kWidth)
    {
        if (width>kMaxWidth)
        {
             _titleLabel.numberOfLines=0;
            self.frame=CGRectMake(0, 0, kMaxWidth, titleSize.height+kMargin);
        }
        else
        {
            self.frame=CGRectMake(0, 0, kMaxWidth, kHeight);
        }
       
    }
    _titleLabel.frame=self.bounds;
    

    UIWindow * keyWindow=[[UIApplication sharedApplication] keyWindow];
    keyWindow.rootViewController.view.userInteractionEnabled=NO;
    self.center=keyWindow.center;
    [keyWindow addSubview:self];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(close:) userInfo:nil repeats:NO];
}


-(void) setTitle:(NSString *)title
{
    _title=title;
    _titleLabel.text=title;
}

-(void) close:(NSTimer *) timer
{
    [timer invalidate];
    [UIView animateWithDuration:0.3f animations:^
    {
        self.alpha=0.0f;
    } completion:^(BOOL finished)
    {
        [self removeFromSuperview];
        UIWindow * keyWindow=[[UIApplication sharedApplication] keyWindow];
        keyWindow.rootViewController.view.userInteractionEnabled=YES;
    }];
}

@end