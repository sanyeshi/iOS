//
//  LuckViewController.m
//  Lottery
//
//  Created by 孙硕磊 on 6/27/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "LuckViewController.h"
#import "ToolView.h"
#import "LuckDialView.h"



@interface LuckViewController ()
{
    ToolView * _toolView;
    LuckDialView * _luckDialView;
}
@end

@implementation LuckViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"幸运选号";
    [self setupBackground];
    [self setupToolView];
    [self setupLuckDialView];
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [_luckDialView startRotate];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [_luckDialView stopRotate];
}

-(void) setupBackground
{
    UIImageView * imageView=[[UIImageView alloc] init];
    imageView.frame=self.view.bounds;
    
    if (Inch35)
    {
        imageView.image=[UIImage imageNamed:@"LuckyBackground@2x.jpg"];
    }
    else if (Inch4)
    {
       imageView.image=[UIImage imageNamed:@"LuckyBackground-568h@2x.jpg"];
    }
    imageView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:imageView];
}

-(void) setupToolView
{
    _toolView=[ToolView toolView];
    CGFloat cx=self.view.frame.size.width*0.5;
    CGFloat cy=_toolView.frame.size.height*0.5+10;
    _toolView.center=CGPointMake(cx, cy);
    [self.view addSubview:_toolView];
    
}

-(void) setupLuckDialView
{
    _luckDialView=[[LuckDialView alloc] init];
    CGFloat x=(self.view.frame.size.width-286)*0.5;
    CGFloat y=CGRectGetMaxY(_toolView.frame);
    CGFloat w=286;
    CGFloat h=286;
    _luckDialView.frame=CGRectMake(x,y, w, h);
    _luckDialView.backgroundColor=[UIColor clearColor];
   // _luckDialView.backgroundColor=[UIColor blueColor];
    
    [self.view addSubview:_luckDialView];
}

@end
