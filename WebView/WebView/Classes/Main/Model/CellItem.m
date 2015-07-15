
//
//  CellItem.m
//  WebView
//
//  Created by 孙硕磊 on 7/14/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CellItem.h"

@implementation CellItem
+(instancetype) cellItemWithTitle:(NSString *)title url:(NSURL *)url
{
    CellItem * cellItem=[[CellItem alloc] init];
    cellItem.title=title;
    cellItem.url=url;
    return cellItem;
}
@end
