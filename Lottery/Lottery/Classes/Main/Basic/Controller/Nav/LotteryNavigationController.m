//
//  LotteryNavigationController.m
//  Lottery
//
//  Created by 孙硕磊 on 6/24/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "LotteryNavigationController.h"

@interface LotteryNavigationController ()

@end

@implementation LotteryNavigationController


#pragma mark 一个类只会调用一次
+(void) initialize
{
    UINavigationBar * navigationBar=[UINavigationBar appearance];
    UIBarButtonItem * barButtonItem=[UIBarButtonItem appearance];
    //设置导航栏背景
    NSString * navigationBarBgName=nil;
    if (iOS7)
    {
         navigationBarBgName=@"NavBar64";
         //返回按钮颜色
         navigationBar.tintColor=[UIColor whiteColor];
         //导航栏按钮颜色
         //barButtonItem.tintColor=[UIColor whiteColor];
        [barButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]
                                                } forState:UIControlStateNormal];
        //导航栏标题颜色
        [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    }
    else
    {
        /*
        //适配iOS7以下系统
        navigationBarBgName=@"NavBar";
        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleBlackOpaque;
        //设置导航栏按钮的背景图片
        [barButtonItem setBackgroundImage:[UIImage imageNamed:@"NavButton"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [barButtonItem setBackgroundImage:[UIImage imageNamed:@"NavButtonPressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        //设置导航栏返回按钮的背景图片
        [barButtonItem setBackButtonBackgroundImage:[UIImage imageNamed:@"NavBackButton"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [barButtonItem setBackButtonBackgroundImage:[UIImage imageNamed:@"NavBackButtonPressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
         //设置导航栏标题为白色
         [navigationBar setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor]}];
         //设置导航栏按钮文字为白色
         [barButtonItem setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor]
         } forState:UIControlStateNormal];
         */
        
    }
    [navigationBar setBackgroundImage:[UIImage imageNamed:navigationBarBgName] forBarMetrics:UIBarMetricsDefault];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}


/*
   状态栏的管理
   1)iOS7之前，UIApplication管理
   2)iOS7之后，交给对应的控制器管理
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end










