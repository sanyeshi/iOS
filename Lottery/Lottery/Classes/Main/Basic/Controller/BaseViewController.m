//
//  BaseViewController.m
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@""
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:nil
                                                                           action:nil];
}
-(void) viewDidAppear:(BOOL)animated
{
   
}

@end
