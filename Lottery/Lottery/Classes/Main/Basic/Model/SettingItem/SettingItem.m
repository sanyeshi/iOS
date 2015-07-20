//
//  SettingItem.m
//  Lottery
//
//  Created by 孙硕磊 on 6/25/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "SettingItem.h"

@implementation SettingItem

+ (instancetype) settingItemWithTtitle:(NSString *)title
{
    SettingItem * item=[[self alloc] init];
    item.title=title;
    return item;
}

+(instancetype) settingItemWithTtitle:(NSString *)title subTitle:(NSString *)subTitle
{
    SettingItem * item=[[self alloc] init];
    item.title=title;
    item.subTitle=subTitle;
    return item;
}

+ (instancetype)settingItemWithIconName:(NSString *)iconName title:(NSString *)title
{
    //self关键字
    SettingItem * item=[[self alloc] init];
    item.iconName=iconName;
    item.title=title;
    return item;
}
@end
