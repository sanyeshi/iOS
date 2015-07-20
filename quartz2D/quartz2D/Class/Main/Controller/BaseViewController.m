//
//  BaseViewController.m
//  quartz2D
//
//  Created by 孙硕磊 on 7/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    return self;
}


@end
