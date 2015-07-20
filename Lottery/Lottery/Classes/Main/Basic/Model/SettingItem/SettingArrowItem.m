//
//  SettingArrowItem.m
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "SettingArrowItem.h"

@implementation SettingArrowItem
+ (instancetype) settingItemWithTtitle:(NSString *)title showViewControllerClass:(Class) showViewControllerClass
{
    SettingArrowItem * item=[self settingItemWithTtitle:title];
    item.showViewControllerClass=showViewControllerClass;
    return item;
}

+(instancetype) settingItemWithIconName:(NSString *) iconName title:(NSString *) title showViewControllerClass:(Class) showViewControllerClass
{
    SettingArrowItem * item=[self settingItemWithIconName:iconName title:title];
    item.showViewControllerClass=showViewControllerClass;
    return item;
}
@end
