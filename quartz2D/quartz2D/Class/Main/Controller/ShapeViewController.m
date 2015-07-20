//
//  ShapeViewController.m
//  quartz2D
//
//  Created by 孙硕磊 on 7/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ShapeViewController.h"
#import "ShapeView.h"

@interface ShapeViewController ()

@end

@implementation ShapeViewController

-(void) loadView
{
    self.view=[[ShapeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor=[UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"绘制图形";
}

@end
