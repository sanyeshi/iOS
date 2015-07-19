//
//  NSLayoutConstraint+Mutil.h
//  自动布局
//
//  Created by 孙硕磊 on 7/19/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (Mutil)

+(NSArray *) constraintsWithVisualFormats:(NSArray *)formats options:(NSLayoutFormatOptions)opts metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

+(NSArray *) constraintsWithVisualFormats:(NSArray *)formats views:(NSDictionary *)views;

@end
