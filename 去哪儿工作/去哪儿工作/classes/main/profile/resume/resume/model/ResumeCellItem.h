//
//  ResumeCellItem.h
//  parttime
//
//  Created by 孙硕磊 on 4/24/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResumeCellItem : NSObject
@property(nonatomic,copy) NSString * title;
@property(nonatomic,strong) Class  willShowViewControllerClass;
- (instancetype)initWithTitle:(NSString *) title willShowViewControllerClass:(Class) class;
@end
