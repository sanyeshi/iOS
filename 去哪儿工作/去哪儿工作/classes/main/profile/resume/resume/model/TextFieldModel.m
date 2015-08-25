//
//  TextField.m
//  parttime
//
//  Created by 孙硕磊 on 4/27/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "TextFieldModel.h"

@implementation TextFieldModel

- (instancetype)initWithTitle:(NSString *) title keyboardType:(TextFieldKeyBoardType) keyboardType
{
    self=[super init];
    if (self)
    {
        self.isEditable=YES;
        self.title=title;
        self.keyboardType=keyboardType;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *) title  content:(NSString *) content keyboardType:(TextFieldKeyBoardType) keyboardType
{
    self=[super init];
    if (self)
    {
        self.isEditable=YES;
        self.title=title;
        self.content=content;
        self.keyboardType=keyboardType;
    }
    return self;
}

@end
