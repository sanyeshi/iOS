//
//  MyJobStateViewController.m
//  parttime
//
//  Created by 孙硕磊 on 5/5/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "MyJobDetailViewController.h"
#import "MyJobDetailView.h"

@interface MyJobDetailViewController ()
{
    MyJobDetailView  *  _myJobDetailView;
}
@end

@implementation MyJobDetailViewController


-(void) loadView
{
    _myJobDetailView=[[MyJobDetailView alloc] init];
    _myJobDetailView.frame=[UIScreen mainScreen].bounds;
    _myJobDetailView.backgroundColor=GlobalBackgroundColor;
    self.view=_myJobDetailView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_myJobDetailView setApplication:_application];
}

@end
