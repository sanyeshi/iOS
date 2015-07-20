//
//  TextViewController.m
//  quartz2D
//
//  Created by 孙硕磊 on 7/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "TextViewController.h"
#import "TextView.h"

@interface TextViewController ()

@end

@implementation TextViewController


-(void) loadView
{
    self.view=[[TextView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor=[UIColor whiteColor];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"文字";
}

@end
