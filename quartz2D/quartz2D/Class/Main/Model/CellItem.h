//
//  CellItem.h
//  quartz2D
//
//  Created by 孙硕磊 on 7/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellItem : NSObject
@property(nonatomic,copy) NSString * title;
@property(nonatomic,assign) Class    showClass;

+(instancetype) cellItemWithTitle:(NSString *) title class:(Class) showClass;

@end
