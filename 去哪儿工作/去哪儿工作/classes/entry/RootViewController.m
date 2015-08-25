//
//  RootViewController.m
//  parttime
//
//  Created by 孙硕磊 on 3/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//


#import "RootViewController.h"
#import "HomeNavigaController.h"
#import "CategoryNavigationViewController.h"
#import "NewsNavigationController.h"
#import "ProfileNavigationController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (instancetype)init
{
    self=[super init];
    if (self)
    {
        //设置tabbar的高亮颜色
        self.tabBar.barTintColor=GlobalTabBarColor;
        self.tabBar.tintColor=GlobalTablBarTextColor;
        [self createSubViewControllers];
    }
    return self;
}

#pragma mark -创建子视图控制器

-(void) createSubViewControllers
{
    HomeNavigaController             * homeNavigaController=[[HomeNavigaController alloc] init];
    CategoryNavigationViewController * categoryNavigationViewController=[[CategoryNavigationViewController alloc] init];
    NewsNavigationController         * newsNavigationController=[[NewsNavigationController alloc] init];
    ProfileNavigationController      * profileNavigationController=[[ProfileNavigationController alloc] init];
    
    NSArray * subViewControlers=@[homeNavigaController,categoryNavigationViewController,newsNavigationController,profileNavigationController];
    self.viewControllers=subViewControlers;
}


@end
