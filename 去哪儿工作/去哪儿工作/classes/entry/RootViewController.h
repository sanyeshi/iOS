//
//  RootViewController.h
//  parttime
//
//  Created by 孙硕磊 on 3/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeNavigaController;
@class JobNavigationViewController;
@class InfoNavigationController;
@class ProfileNavigationController;

@interface RootViewController : UITabBarController
@property(nonatomic,weak) HomeNavigaController          * homeNavigaController;
@property(nonatomic,weak) JobNavigationViewController   * jobNavigationViewController;
@property(nonatomic,weak) InfoNavigationController      * infoNavigationController;
@property(nonatomic,weak) ProfileNavigationController   * profileNavigationController;
@end
