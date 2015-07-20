//
//  SettingItemTool.h
//  Lottery
//
//  Created by 孙硕磊 on 6/27/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingItemTool : NSObject
+(id) objectForKey:(NSString *) key;
+(void) setObject:(id) object forKey:(NSString *) key;

+(BOOL) boolForKey:(NSString *) key;
+(void) setBool:(BOOL) value forKey:(NSString *) key;
@end
