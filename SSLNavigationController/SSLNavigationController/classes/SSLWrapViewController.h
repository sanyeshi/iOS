//
//  SSLWarpViewController.h
//  SSLNavigationController
//
//  Created by 孙硕磊 on 16/2/5.
//  Copyright © 2016年 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSLWrapNavigationController : UINavigationController
@end


@interface SSLWrapViewController : UIViewController
+ (SSLWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;
@end