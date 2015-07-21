//
//  LuckDialView.m
//  Lottery
//
//  Created by 孙硕磊 on 7/21/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "LuckDialView.h"
#import "LuckDialButton.h"

#define Transform2Angle(transform) atan2(transform.b, transform.a)

@interface LuckDialView ()
{
    UIButton * _selectedButton;
    CADisplayLink * _timer;
    CGFloat  _angle;
}
@end

@implementation LuckDialView


-(void) drawRect:(CGRect)rect
{
    UIImage * baseImage=[UIImage imageNamed:@"LuckyBaseBackground"];
    UIImage * wheel=[UIImage imageNamed:@"LuckyRotateWheel"];
    
    //绘制背景
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [baseImage drawInRect:rect];
    
    //绘制背景
    CGContextRestoreGState(ctx);
    [wheel drawInRect:rect];
    
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setupSubViews];
    }
    return self;
}


-(void) setupSubViews
{
    CGFloat w=66.0;
    CGFloat h=143.0;
    CGPoint position=CGPointMake(143.0, 143.0f);
    CGFloat angle=M_PI/6;
    
    UIImage * selectedImage=[UIImage imageNamed:@"LuckyRototeSelected"];
    UIImage * image=[UIImage imageNamed:@"LuckyAstrology"];
    CGFloat   imageW=(image.size.width*image.scale)/12;
    CGFloat   imageH=image.size.height*image.scale;

    
    for (int i=0; i<12; i++)
    {
        LuckDialButton * button=[[LuckDialButton alloc] init];
        button.tag=i;
        button.bounds=CGRectMake(0.0, 0.0, w, h);
        button.layer.anchorPoint=CGPointMake(0.5, 1.0);
        button.layer.position=position;
        
        //截取图片是以像素为单位，而不是以点为单位
        CGImageRef imageRef=CGImageCreateWithImageInRect(image.CGImage, CGRectMake(imageW*i,0, imageW, imageH));
        [button setImage:[UIImage imageWithCGImage:imageRef] forState:UIControlStateNormal];
        [button setBackgroundImage:selectedImage forState:UIControlStateSelected];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        button.transform=CGAffineTransformMakeRotation(angle*i);
        [self addSubview:button];
        
        if (i==0)
        {
            [self click:button];
        }
    }
    
    //添加圆心处的按钮
    UIButton * centerButton=[[UIButton alloc] init];
    centerButton.bounds=CGRectMake(0, 0, 81,81);
    centerButton.center=position;
    [centerButton setImage:[UIImage imageNamed:@"LuckyCenterButton"] forState:UIControlStateNormal];
    [centerButton setImage:[UIImage imageNamed:@"LuckyCenterButtonPressed"] forState:UIControlStateHighlighted];
    [centerButton addTarget:self action:@selector(quickRotate) forControlEvents:UIControlEventTouchDown];
    [self addSubview:centerButton];
}


-(void) click:(UIButton *) button
{
    if (_selectedButton!=button)
    {
        _selectedButton.selected=NO;
        _selectedButton=button;
        _selectedButton.selected=YES;
    }
}


-(void) startRotate
{
    if (!_timer)
    {
        _angle=M_PI/60;
        _timer=[CADisplayLink displayLinkWithTarget:self selector:@selector(rotating)];
        [_timer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

-(void) stopRotate
{
    if (_timer)
    {
        [_timer removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        _timer=nil;
    }
}

-(void) quickRotate
{
    CABasicAnimation * ani=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    //NSLog(@"%f",Transform2Angle(_selectedButton.transform));
    
    [ani setToValue:@(M_PI*20-Transform2Angle(_selectedButton.transform))];
    //[ani setToValue:@(M_PI*20)];
    [ani setDuration:2.0f];
    ani.delegate=self;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:ani forKey:nil];
    
}

-(void) rotating
{
    //此处不能采用核心动画，因为在旋转过程中，用户可能会点击按钮；而核心动画，控件的实际位置并未发生改变
    self.transform=CGAffineTransformRotate(self.transform, _timer.duration*_angle);
}


-(void) animationDidStart:(CAAnimation *)anim
{
    //快速旋转，采用核心动画，禁止用户交互
    [self stopRotate];
    self.userInteractionEnabled=NO;
}

-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self startRotate];
    self.userInteractionEnabled=YES;
}

@end
