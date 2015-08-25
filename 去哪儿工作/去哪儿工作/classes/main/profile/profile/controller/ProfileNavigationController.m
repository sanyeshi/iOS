//
//  ProfileViewController.m
//  parttime
//
//  Created by 孙硕磊 on 3/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
/**
 *   ProfileNavigationController为导航控制器，其根控制器为ProfileRootViewController
 */

#import "ProfileNavigationController.h"
#import "ProfileRootViewController.h"

@interface ProfileNavigationController ()
{
    CGRect _tabBarFrame;
}
@end

@implementation ProfileNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.rootViewController=[[ProfileRootViewController alloc]init];
    self.delegate=self;
}


/**
 *  自定义tabBarItem
 */
-(void) customTarBarItem
{
    //设置tabbarItem
    UIImage * image=[UIImage imageNamed:@"tabbar_profile.png"];
    //UIImage * selectedImage=[UIImage imageNamed:@"tabbar_homepage.png"];
    //[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"我" image:image selectedImage:image];

}


#pragma mark -视图切换
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //在视图切换时，为了实现tabBar和控制器同步切换，需要将tabBar从父视图中移除，并添加在viewController的上一个视图;
    if (viewController!=self.rootViewController)
    {
        UITabBar * tabBar=self.tabBarController.tabBar;
        [tabBar removeFromSuperview];
        _tabBarFrame=tabBar.frame;
        [self.rootViewController.view addSubview:tabBar];
    }
    //导航栏
    if (viewController==self.rootViewController)
    {
        self.navigationBar.hidden=YES;
    }
    else
    {
        self.navigationBar.hidden=NO;
    }
}

/*
   视图控制器已经出现,还原tabBar
 */
 -(void) navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController==self.rootViewController)
    {
        if (!CGRectEqualToRect(_tabBarFrame, CGRectMake(0, 0, 0, 0)))
        {
            UITabBar * tabBar=self.tabBarController.tabBar;
            [tabBar removeFromSuperview];
            [self.tabBarController.view addSubview:tabBar];
        }

    }
}
@end
