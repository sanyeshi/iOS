//
//  HelpViewController.m
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "HelpViewController.h"
#import "HtmlModel.h"
#import "BaseNavigationController.h"
#import "HtmlViewController.h"


@interface HelpViewController ()
{
    NSArray * _htmlModels;
}
@end

@implementation HelpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"帮助";
    
    //加载json
    NSArray * array=LotteryJSON(@"help.json");
    NSMutableArray * mutableArrItem=[NSMutableArray arrayWithCapacity:array.count];
    NSMutableArray * mutableArrModel=[NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary * dict in array)
    {
        SettingArrowItem * item=[SettingArrowItem settingItemWithTtitle:[dict valueForKey:@"title"]];
        [mutableArrItem addObject:item];
        
        HtmlModel * model=[HtmlModel htmlModelWithDict:dict];
        [mutableArrModel addObject:model];
    }
    
    SettingGroup * group=[[SettingGroup alloc] init];
    group.settingItems=[mutableArrItem copy];
    _groups=@[group];
    
    _htmlModels=[mutableArrModel copy];
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HtmlViewController * html=[[HtmlViewController alloc] init];
    html.htmlModel=_htmlModels[indexPath.row];
    
    BaseNavigationController * nav=[[BaseNavigationController alloc] initWithRootViewController:html];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
