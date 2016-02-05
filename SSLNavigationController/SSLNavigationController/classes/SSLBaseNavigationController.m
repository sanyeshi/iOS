//
//  SSLBaseNavigationController.m
//  SSLNavigationController
//
//  Created by 孙硕磊 on 16/2/5.
//  Copyright © 2016年 dhu.cst. All rights reserved.
//

#import "SSLBaseNavigationController.h"

@interface SSLBaseNavigationController ()

@end

@implementation SSLBaseNavigationController

+ (instancetype)shareNavgationController {
    
    static SSLBaseNavigationController *baseNavigationController;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseNavigationController = [[SSLBaseNavigationController alloc] init];
    });
    return baseNavigationController;
}

- (void)viewDidLoad{
    self.navigationBar.hidden=YES;
}
@end
