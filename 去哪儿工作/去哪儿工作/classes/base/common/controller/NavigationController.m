//
//  NavigationController.m
//  parttime
//
//  Created by 孙硕磊 on 4/19/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()
{
   UIViewController * _rootViewController;
}
@end

@implementation NavigationController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self customNavigationBar];
        [self customTarBarItem];
    }
    return self;
}

#pragma mark - 自定义navigationBar
-(void) customNavigationBar
{
    self.navigationBar.barStyle=UIBarStyleBlack;
    self.navigationBar.translucent=YES;
    self.navigationBar.barTintColor=GlobalTintColor;
    self.navigationBar.tintColor=GlobalNavigationBarTextColor;
}

#pragma mark -自定义tabBarItem
-(void) customTarBarItem
{
    
}


#pragma mark -设置根控制器
-(void) setRootViewController:(UIViewController *) rootViewController
{
    _rootViewController=rootViewController;
    [self pushViewController:_rootViewController animated:NO];
}

-(UIViewController *) rootViewController
{
    return _rootViewController;
}


- (void)viewDidAppear:(BOOL)animated
{
    
}


@end
