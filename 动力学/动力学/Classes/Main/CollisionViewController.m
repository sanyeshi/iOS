//
//  CollisionViewController.m
//  动力学
//
//  Created by 孙硕磊 on 7/15/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CollisionViewController.h"

@interface CollisionViewController ()<UICollisionBehaviorDelegate>
{
    UIDynamicAnimator * _animator;
}
@end

@implementation CollisionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"碰撞行为";
    self.view.backgroundColor=[UIColor whiteColor];
    
    //动力学元素,也即控件
    UIView * view=[[UIView alloc] init];
    view.frame=CGRectMake(160, 100, 100, 100);
    view.backgroundColor=[UIColor blueColor];
    [self.view addSubview:view];
    
    //障碍物
    UIView * barrier=[[UIView alloc] init];
    barrier.frame=CGRectMake(0, 280, 200, 20);
    barrier.backgroundColor=[UIColor redColor];
    [self.view addSubview:barrier];
    
    
    _animator=[[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIDynamicBehavior * gravity=[[UIGravityBehavior alloc] initWithItems:@[view]];
    [_animator addBehavior:gravity];
    
    //默认情况下，碰撞检测的范围为参照视图的边界，还可以添加边界检测的范围，或添加边界检测的路径
    UICollisionBehavior * collision=[[UICollisionBehavior alloc] initWithItems:@[view]];
    collision.translatesReferenceBoundsIntoBoundary=YES;
    [_animator addBehavior:collision];
    
    //添加障碍物的边界
    CGPoint fromPoint=barrier.frame.origin;
    CGPoint toPoint=CGPointMake(fromPoint.x+barrier.frame.size.width, fromPoint.y+barrier.frame.size.height);
    [collision addBoundaryWithIdentifier:@"barrier" fromPoint:fromPoint toPoint:toPoint];
    
    //在发生碰撞时，我们可以接收通知，以便做相应的处理
    collision.collisionDelegate=self;
    
    //可以跟踪，物体运动的轨迹，在运动的每个step就会调用该方法
    collision.action=^{
        //注意循环引用
    };
}


-(void) collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    //如，在碰撞发生时，可以播放音效等
    
}

-(void) dealloc
{
    NSLog(@"dealloc......");
}


@end
