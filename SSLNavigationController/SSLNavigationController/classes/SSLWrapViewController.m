//
//  SSLWarpViewController.m
//  SSLNavigationController
//
//  Created by 孙硕磊 on 16/2/5.
//  Copyright © 2016年 dhu.cst. All rights reserved.
//

#import "SSLWrapViewController.h"
#import "SSLBaseNavigationController.h"




#pragma mark - SSLWrapNavigationController

@implementation SSLWrapNavigationController

//translate wrapNavController's push and pop to baseNavController's
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [[SSLBaseNavigationController shareNavgationController] popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [[SSLBaseNavigationController shareNavgationController] popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    int index=0;
    for (UIViewController *wrapViewController in [SSLBaseNavigationController shareNavgationController].viewControllers){
        if ([wrapViewController isKindOfClass:[SSLWrapViewController class]]){
             UINavigationController *wrapNavController = wrapViewController.childViewControllers.firstObject;
            if (wrapNavController.viewControllers.firstObject==viewController){
                break;
            }
        }
         index++;
      }
    return [[SSLBaseNavigationController shareNavgationController] popToViewController:[SSLBaseNavigationController shareNavgationController].viewControllers[index] animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStylePlain target:self action:@selector(didTapBackButton)];
    //wrap the viewController(vc) into wrapViewController to make different vc have distinct appearance
    [[SSLBaseNavigationController shareNavgationController] pushViewController:[SSLWrapViewController wrapViewControllerWithViewController:viewController] animated:animated];
}

- (void)didTapBackButton {
    [[SSLBaseNavigationController shareNavgationController] popViewControllerAnimated:YES];
}

@end

#pragma mark - SSLWrapViewController

@implementation SSLWrapViewController

+ (SSLWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController {
    
    SSLWrapNavigationController *wrapNavController = [[SSLWrapNavigationController alloc] init];
    wrapNavController.viewControllers = @[viewController];
    //insert wrapNavController.view(holds navBar and viewContrller.view) to wrapViewController.view
    SSLWrapViewController *wrapViewController = [[SSLWrapViewController alloc] init];
    [wrapViewController.view addSubview:wrapNavController.view];
    [wrapViewController addChildViewController:wrapNavController];
    
    return wrapViewController;
}
@end

