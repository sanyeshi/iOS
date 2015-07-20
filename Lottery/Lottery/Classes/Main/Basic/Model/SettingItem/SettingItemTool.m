//
//  SettingItemTool.m
//  Lottery
//
//  Created by 孙硕磊 on 6/27/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "SettingItemTool.h"

@implementation SettingItemTool

+(id) objectForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+(void) setObject:(id)object forKey:(NSString *)key
{
    if (key)
    {
      [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    }
}

+(BOOL) boolForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+(void) setBool:(BOOL)value forKey:(NSString *)key
{
    if (key)
    {
       [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    }
}

@end
