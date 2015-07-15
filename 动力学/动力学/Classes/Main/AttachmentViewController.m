//
//  AttachmentViewController.m
//  动力学
//
//  Created by 孙硕磊 on 7/15/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "AttachmentViewController.h"

@interface AttachmentViewController ()
{
    UIDynamicAnimator * _animator;
    UIAttachmentBehavior * _attachment;
    
    UIView * _headerView;
    
}
@end

@implementation AttachmentViewController

/*
   吸附行为，表现为一个视图吸附在另一个视图上，当一个视图运动时，吸附的视图也跟随运动
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"吸附行为";
    self.view.backgroundColor=[UIColor whiteColor];
    
    NSMutableArray * array=[NSMutableArray array];
    //添加视图元素
    CGFloat x=10.0f;
    CGFloat y=100.0f;
    CGFloat width=20.0f;
    CGFloat height=20.0f;
    for (int i=0; i<8; i++)
    {
        UIView * view=[[UIView alloc] init];
        view.frame=CGRectMake(x+i*width, y, width, height);
        view.backgroundColor=[UIColor greenColor];
        view.layer.cornerRadius=10.0f;
        [self.view addSubview:view];
        [array addObject:view];
    }
    
    _headerView=[[UIView alloc] init];
    _headerView.bounds=CGRectMake(0.0f,0.0f,40.0f, 40.0f);
    _headerView.center=CGPointMake(x+width*8+20.0f,y+height*0.5);
    _headerView.layer.cornerRadius=20.0f;
    _headerView.backgroundColor=[UIColor redColor];
    [self.view addSubview:_headerView];
    [array addObject:_headerView];
    
    
    //animator
    _animator=[[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    //添加吸附行为
    for (int i=0; i<8; i++)
    {
        UIAttachmentBehavior * attachment=[[UIAttachmentBehavior alloc] initWithItem:array[i] attachedToItem:array[i+1]];
        [_animator addBehavior:attachment];
    }
    
    UIGravityBehavior * gravity=[[UIGravityBehavior alloc] initWithItems:array];
    [_animator addBehavior:gravity];
    
    UICollisionBehavior * collision=[[UICollisionBehavior alloc] initWithItems:array];
    collision.translatesReferenceBoundsIntoBoundary=YES;
    [_animator addBehavior:collision];
    
    //添加拖动手势
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}

-(void) pan:(UIPanGestureRecognizer *) gestureRecognizer
{
    //手势开始,添加吸附行为
    if (gestureRecognizer.state==UIGestureRecognizerStateBegan)
    {
        CGPoint point=[gestureRecognizer locationInView:self.view];
        _attachment=[[UIAttachmentBehavior alloc] initWithItem:_headerView attachedToAnchor:point];
        [_animator addBehavior:_attachment];
    }
    else if(gestureRecognizer.state==UIGestureRecognizerStateChanged)
    {
        //改变anchorPoint
        [_attachment setAnchorPoint:[gestureRecognizer locationInView:self.view]];
    }
    else if(gestureRecognizer.state==UIGestureRecognizerStateEnded)
    {
        //清除吸附行为
        [_animator removeBehavior:_attachment];
        _attachment=nil;
    }
    
}


@end
