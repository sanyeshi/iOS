//
//  ProfileCellItem.m
//  parttime
//
//  Created by 孙硕磊 on 5/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ProfileCellItem.h"

@implementation ProfileCellItem
- (instancetype)initWithIconName:(NSString *) iconName title:(NSString *) title willShowViewControllerClass:(Class) class
{
    self = [super init];
    if (self)
    {
        self.iconName=iconName;
        self.title=title;
        self.willShowViewControllerClass=class;
    }
    return self;

}
@end
