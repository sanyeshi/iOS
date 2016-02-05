//
//  ProfileViewController.m
//  SSLNavigationController
//
//  Created by 孙硕磊 on 16/2/5.
//  Copyright © 2016年 dhu.cst. All rights reserved.
//

#import "ProfileViewController.h"
#import "NormalViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden=YES;
    self.view.backgroundColor=[UIColor yellowColor];
    
    UIButton *nextBtn=[UIButton buttonWithType:UIButtonTypeContactAdd];
    nextBtn.center=CGPointMake(100, 100);
    [nextBtn addTarget:self action:@selector(didNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
}


-(void) didNext{
    [self.navigationController pushViewController:[[NormalViewController alloc] init] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
