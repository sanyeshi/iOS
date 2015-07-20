//
//  ImageViewController.m
//  quartz2D
//
//  Created by 孙硕磊 on 7/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ImageViewController.h"
#import "ImageView.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

-(void) loadView
{
    self.view=[[ImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view.backgroundColor=[UIColor whiteColor];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"图片";
}

@end
