//
//  LineViewController.m
//  quartz2D
//
//  Created by 孙硕磊 on 7/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "LineViewController.h"
#import "LineView.h"


@interface LineViewController ()

@end

@implementation LineViewController


-(void) loadView
{
    LineView * view=[[LineView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor=[UIColor whiteColor];
    self.view=view;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"画线";
}

@end
