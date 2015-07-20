//
//  SettingItem.h
//  Lottery
//
//  Created by 孙硕磊 on 6/25/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingItem : NSObject

@property(nonatomic,copy)   NSString * iconName;
@property(nonatomic,copy)   NSString * title;
@property(nonatomic,copy)   NSString * subTitle;
@property(nonatomic,copy)   void (^operation)() ;

+(instancetype) settingItemWithTtitle:(NSString *) title;
+(instancetype) settingItemWithTtitle:(NSString *) title subTitle:(NSString *) subTitle;
+(instancetype) settingItemWithIconName:(NSString *) iconName title:(NSString *) title;

@end
