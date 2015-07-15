//
//  MainViewController.m
//  动力学
//
//  Created by 孙硕磊 on 7/15/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "MainViewController.h"
#import "GravityViewController.h"
#import "CollisionViewController.h"
#import "AttachmentViewController.h"
#import "PushViewController.h"



@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
}
@end

@implementation MainViewController


-(void) loadView
{
    _tableView=[[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    self.view=_tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"动力学";
}



-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifer=@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    //覆盖数据要完全
    if (indexPath.row==0)
    {
        cell.textLabel.text=@"重力行为";
    }
    else if (indexPath.row==1)
    {
          cell.textLabel.text=@"碰撞检测";
    }
    else if (indexPath.row==2)
    {
          cell.textLabel.text=@"吸附行为";
    }
    else if (indexPath.row==3)
    {
          cell.textLabel.text=@"推动行为";
    }
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController * viewController=nil;
    if (indexPath.row==0)
    {
        viewController=[[GravityViewController alloc] init];
    }
    else if (indexPath.row==1)
    {
        
        viewController=[[CollisionViewController alloc] init];
    }
    else if (indexPath.row==2)
    {
        viewController=[[AttachmentViewController alloc] init];
    }
    else if (indexPath.row==3)
    {
         viewController=[[PushViewController alloc] init];
    }
    [self.navigationController pushViewController:viewController animated:YES];

}


@end
