//
//  TagEditionViewController.h
//  parttime
//
//  Created by 孙硕磊 on 5/18/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TagViewController;

typedef enum : NSUInteger
{
  TagAccessTypeWrite,
  TagAccessTypeUpdate
} TagAccessType;

@interface TagEditionViewController : UITableViewController

@property(nonatomic,strong)  TagViewController * parent;
@property(nonatomic,assign)  NSInteger           index;
@property(nonatomic,assign)  TagAccessType       tagAccessType;
@end
