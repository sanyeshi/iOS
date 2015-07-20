//
//  AppTabBarController.m
//  lottery
//
//  Created by 孙硕磊 on 4/15/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "LotteryTabBarController.h"
#import "LotteryTabBar.h"

#import "HallViewController.h"
#import "UnionViewController.h"
#import "AwardViewController.h"
#import "LuckViewController.h"
#import "ProfileViewController.h"


@interface LotteryTabBarController () <LotteryTabBarDelegate>
{
    LotteryTabBar * _appTabBar;
}
@end

@implementation LotteryTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@""
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:nil
                                                                           action:nil];

    
    HallViewController  * hallViewController=[[HallViewController alloc] init];
    UnionViewController * unionViewController=[[UnionViewController alloc] init];
    AwardViewController * awardViewController=[[AwardViewController alloc] init];
    LuckViewController  * luckViewController=[[LuckViewController alloc] init];
    ProfileViewController * profileViewController=[[ProfileViewController alloc] init];
    
    self.viewControllers=@[hallViewController,unionViewController,awardViewController,luckViewController,profileViewController];
    /**
       iOS7及以上系统中，UIViewController中的视图将全屏显示，而navigationBar和tabBar会覆盖其上，所以视图的部分内容
       将会被遮挡。
       而edgesForExtendedLayout 默认值为UIRectEdgeAll
       UIRectEdgeNone不要往四周边缘展开(按照iOS6方式)
       此外，iOS7中增加以下属性:
       extendedLayoutIncludesOpaqueBars
       automaticallyAdjustsScrollViewInsets,该属性会自动调节UIScrollView的contentInsets属性
     */
    if(iOS7)
    {
      self.edgesForExtendedLayout=UIRectEdgeNone;
        for (UIViewController * vc in self.childViewControllers)
        {
            vc.edgesForExtendedLayout=UIRectEdgeNone;
        }
    }
    
}


#pragma mark --自定义UITabBar
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //确保执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /*
         tabBar内部的子控件为UITabBarButton，该控件为私有控件，用户不能创建,所以在自定义tabBar时需要删除原有的tabBar，模仿UITabBar自定义UITabBar
         for (UIColor * btn in self.tabBar.subviews)
         {
           NSLog(@"%@",btn);
         }
         */
        //1.删除默认的tabbar
        [self.tabBar removeFromSuperview];
        //2.创建tabBar
        _appTabBar=[[LotteryTabBar alloc] init];
        _appTabBar.frame=self.tabBar.frame;
        _appTabBar.delegate=self;
        _appTabBar.defaultIndex=0;
        [self.view addSubview:_appTabBar];
        
    });
}

-(void) viewDidAppear:(BOOL)animated
{
   
}


-(void) lotteryTabBar:(LotteryTabBar *)lotteryTabBar didClickedTabBarButtonAtIndex:(NSUInteger)index
{
    //切换视图
    self.selectedIndex=index;
    UIViewController * targetViewController=self.childViewControllers[index];
    //
    self.navigationItem.leftBarButtonItem=targetViewController.navigationItem.leftBarButtonItem;
    self.navigationItem.leftBarButtonItems=targetViewController.navigationItem.leftBarButtonItems;
    self.navigationItem.rightBarButtonItem=targetViewController.navigationItem.rightBarButtonItem;
    self.navigationItem.rightBarButtonItems=targetViewController.navigationItem.rightBarButtonItems;
    self.navigationItem.titleView=targetViewController.navigationItem.titleView;
    self.navigationItem.title=targetViewController.navigationItem.title;
}
@end
