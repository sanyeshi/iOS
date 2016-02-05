//
//  MainViewController.m
//  SSLNavigationController
//
//  Created by 孙硕磊 on 16/2/5.
//  Copyright © 2016年 dhu.cst. All rights reserved.
//

#import "MainViewController.h"
#import "SSLWrapViewController.h"
#import "HomeViewController.h"
#import "ProfileViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SSLWrapViewController * home=[SSLWrapViewController wrapViewControllerWithViewController:[[HomeViewController alloc] init]];
    home.tabBarItem=[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:1];
    self.viewControllers=@[home];
    
    SSLWrapViewController * profile=[SSLWrapViewController wrapViewControllerWithViewController:[[ProfileViewController alloc]init]];
    profile.tabBarItem=[[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemMore tag:2];
    self.viewControllers=@[home,profile];
}
@end
