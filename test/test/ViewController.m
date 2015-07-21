//
//  ViewController.m
//  test
//
//  Created by 孙硕磊 on 7/21/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.frame=CGRectMake(0.0f, 100.0f,29.0f, 29.0f);
    
    //bounds,x、y以控件自己内容的左上角为坐标原点(0,0)
    CGRect bounds=self.view.bounds;
    //控件的所有内容往下走20
    bounds.origin.y=100;
    //self.view.bounds=bounds;
    //[self.view addSubview:btn];
    
    
    UIView * redView=[[UIView alloc] init];
    redView.backgroundColor=[UIColor redColor];
    redView.frame=CGRectMake(0, 0, 300, 300);
    redView.bounds=CGRectMake(0, 150, 300, 300);
    redView.clipsToBounds=YES;
    [self.view addSubview:redView];
    
    UIView * blueView=[[UIView alloc] init];
    blueView.backgroundColor=[UIColor blueColor];
    blueView.frame=CGRectMake(0, 300, 150, 150);
    [redView addSubview:blueView];
    
    NSLog(@"%@",NSStringFromCGRect(redView.bounds));
}


-(BOOL) prefersStatusBarHidden
{
    return YES;
}
@end
