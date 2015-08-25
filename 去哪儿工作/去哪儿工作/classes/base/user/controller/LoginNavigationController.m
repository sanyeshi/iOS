//
//  LoginNavigationController.m
//  去哪儿工作
//
//  Created by 孙硕磊 on 5/9/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "LoginNavigationController.h"
#import "LoginViewController.h"


@interface LoginNavigationController ()

@end

@implementation LoginNavigationController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.rootViewController=[[LoginViewController alloc] init];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}
@end
