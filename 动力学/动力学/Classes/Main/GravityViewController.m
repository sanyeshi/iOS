//
//  GravityViewController.m
//  动力学
//
//  Created by 孙硕磊 on 7/15/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "GravityViewController.h"

@interface GravityViewController ()
{
    UIDynamicAnimator * _animator;
}
@end

@implementation GravityViewController


/*
   使用UIDynamic步骤:
   1.实例化一个动力学元素，UIView及其子控件；
   2.实例化一个UIDynamicAnimator,是用于动力学元素与底层物理引擎的桥梁或中介;
     initWithReferenceView中的view指定物理仿真的空间大小，在什么空间内实现物理仿真，也即参照系视图。
   3.实例化要仿真的行为，如:重力仿真，碰撞仿真等
   4.将定义的行为依次添加到animator中，物理仿真即可开始
 **/
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"重力行为";
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIView * view=[[UIView alloc] init];
    view.frame=CGRectMake(100, 100, 100, 100);
    view.backgroundColor=[UIColor blueColor];
    [self.view addSubview:view];
    
    //初始化一个animator
    _animator=[[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    //初始化重力行为
    UIDynamicBehavior * gravity=[[UIGravityBehavior alloc] initWithItems:@[view]];
    
    //将重力行为添加到animator
    [_animator addBehavior:gravity];
    
    //初始化碰撞行为
    UICollisionBehavior * collision=[[UICollisionBehavior alloc] initWithItems:@[view]];
    //默认已参考视图的边界为碰撞检测范围
    collision.translatesReferenceBoundsIntoBoundary=YES;
    [_animator addBehavior:collision];
    
    

}



@end
