//
//  SettingLabelItem.m
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "SettingLabelItem.h"
#import "SettingItemTool.h"

@implementation SettingLabelItem

-(void) setText:(NSString *)text
{
    _text=text;
    //存档
    [SettingItemTool setObject:text forKey:self.key];
}

/*
-(void) setKey:(NSString *)key
{
    super.key=key;
    if (_text)
    {
      [SettingItemTool setObject:_text forKey:key];   
    }
}
 */
@end
