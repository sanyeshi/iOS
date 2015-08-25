//
//  ELCConsole.m
//  ELCImagePickerDemo
//
//  Created by Seamus on 14-7-11.
//  Copyright (c) 2014年 ELC Technologies. All rights reserved.
//

#import "ELCConsole.h"

static ELCConsole *_mainconsole;

@implementation ELCConsole
+ (ELCConsole *)mainConsole
{
    if (!_mainconsole)
    {
        _mainconsole = [[ELCConsole alloc] init];
    }
    return _mainconsole;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        myIndex = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    myIndex = nil;
    _mainconsole = nil;
}

- (void)addIndex:(NSUInteger)index
{
    if (![myIndex containsObject:@(index)])
    {
        [myIndex addObject:@(index)];
    }
}

- (void)removeIndex:(NSUInteger)index
{
    [myIndex removeObject:@(index)];
}

- (void)removeAllIndex
{
    [myIndex removeAllObjects];
}

- (NSUInteger)currIndex
{
    [myIndex sortUsingSelector:@selector(compare:)];
    
    for (int i = 0; i < [myIndex count]; i++)
    {
        int c = [[myIndex objectAtIndex:i] intValue];
        if (c != i)
        {
            return i;
        }
    }
    return (int)[myIndex count];
}

- (NSUInteger)numOfSelectedElements
{
    
    return [myIndex count];
}

@end
