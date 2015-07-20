//
//  SettingGroup.h
//  Lottery
//
//  Created by 孙硕磊 on 6/25/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingGroup : NSObject
@property(nonatomic,copy)   NSString * headerTitle;
@property(nonatomic,copy)   NSString * footerTitle;
@property(nonatomic,strong) NSArray  * settingItems;

@end
