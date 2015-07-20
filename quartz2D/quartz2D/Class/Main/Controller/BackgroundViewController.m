//
//  BackgroundViewController.m
//  quartz2D
//
//  Created by 孙硕磊 on 7/4/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "BackgroundViewController.h"

@interface BackgroundViewController ()

@end

@implementation BackgroundViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[self background]];
}


#pragma mark -自绘背景
-(UIImage *) background
{
    CGFloat width=self.view.bounds.size.width;
    CGFloat height=44;
    UIGraphicsBeginImageContext(CGSizeMake(width,height));
    [[UIColor orangeColor] set];
    UIRectFill(CGRectMake(0, 0, width,height));
    
    [[UIColor lightGrayColor] set];
    UIRectFill(CGRectMake(0, height-1, width, 1));
    
    UIImage * bg=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return bg;
}

@end
