//
//  LuckViewController.m
//  Lottery
//
//  Created by 孙硕磊 on 6/27/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "LuckViewController.h"
#import "ToolView.h"


@interface LuckViewController ()

@end

@implementation LuckViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"幸运选号";
    [self setupBackground];
    [self setupToolView];
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
    ToolView * toolView=[ToolView toolView];
    CGFloat cx=self.view.frame.size.width*0.5;
    CGFloat cy=toolView.frame.size.height*0.5+10;
    toolView.center=CGPointMake(cx, cy);
    [self.view addSubview:toolView];
    
}

@end
