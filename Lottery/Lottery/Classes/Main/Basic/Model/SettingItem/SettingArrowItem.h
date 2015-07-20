//
//  SettingArrowItem.h
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "SettingItem.h"

@interface SettingArrowItem : SettingItem
@property(nonatomic,assign) Class  showViewControllerClass;

+ (instancetype) settingItemWithTtitle:(NSString *)title showViewControllerClass:(Class) showViewControllerClass;
+(instancetype) settingItemWithIconName:(NSString *) iconName title:(NSString *) title showViewControllerClass:(Class) showViewControllerClass;
@end
