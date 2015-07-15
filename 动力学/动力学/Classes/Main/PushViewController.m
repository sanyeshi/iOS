//
//  PushViewController.m
//  动力学
//
//  Created by 孙硕磊 on 7/15/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()
{
    UIDynamicAnimator * _animator;
    UIView * _view;
}
@end

@implementation PushViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"推动行为";
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIView * view=[[UIView alloc] init];
    view.frame=CGRectMake(100, self.view.frame.size.height-100, 100, 100);
    view.backgroundColor=[UIColor blueColor];
    [self.view addSubview:view];
    _view=view;
    
    _animator=[[UIDynamicAnimator alloc] init];
    
    //添加点按手势
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
}

-(void) tap:(UITapGestureRecognizer *) gestureRecognizer
{
    
    //实例化一个推的行为
    UIPushBehavior * push=[[UIPushBehavior alloc] initWithItems:@[_view] mode:UIPushBehaviorModeInstantaneous];
    [_animator addBehavior:push];
    push.angle=0.0f;
    push.magnitude=0.05;
    //使用单次推行为需要激活
    push.active=YES;
    
}

@end
