//
//  NormalViewController.m
//  SSLNavigationController
//
//  Created by 孙硕磊 on 16/2/5.
//  Copyright © 2016年 dhu.cst. All rights reserved.
//

#import "NormalViewController.h"
#import "SSLBaseNavigationController.h"

@interface NormalViewController ()

@end

@implementation NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor=[UIColor redColor];
    self.view.backgroundColor=[UIColor whiteColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
