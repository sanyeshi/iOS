//
//  CellItem.m
//  quartz2D
//
//  Created by 孙硕磊 on 7/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CellItem.h"

@implementation CellItem

+(instancetype) cellItemWithTitle:(NSString *)title class:(Class)showClass
{
    CellItem * item=[[CellItem alloc] init];
    item.title=title;
    item.showClass=showClass;
    return item;
}
@end
