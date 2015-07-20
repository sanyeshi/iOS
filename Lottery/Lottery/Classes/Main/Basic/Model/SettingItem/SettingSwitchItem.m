//
//  SettingSwitchItem.m
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "SettingSwitchItem.h"
#import "SettingItemTool.h"

@implementation SettingSwitchItem
-(void) setOn:(BOOL)on
{
    _on=on;
    [SettingItemTool setBool:on forKey:self.key];
}

/*
-(void) setKey:(NSString *)key
{
    LotteryLog(@"%d",_on);
    super.key=key;
    [SettingItemTool setBool:_on forKey:key];
}
*/

@end
