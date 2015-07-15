//
//  CellItem.h
//  WebView
//
//  Created by 孙硕磊 on 7/14/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellItem : NSObject
@property(nonatomic,copy)   NSString * title;
@property(nonatomic,strong) NSURL    * url;

+(instancetype) cellItemWithTitle:(NSString *) title url:(NSURL *) url;
@end
