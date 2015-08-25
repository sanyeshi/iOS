//
//  ResumeCellItem.m
//  parttime
//
//  Created by 孙硕磊 on 4/24/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ResumeCellItem.h"

@implementation ResumeCellItem
- (instancetype)initWithTitle:(NSString *) title willShowViewControllerClass:(Class) class
{
    self = [super init];
    if (self)
    {
        self.title=title;
        self.willShowViewControllerClass=class;
    }
    return self;
}
@end
