//
//  MyReceiptViewController.h
//  parttime
//
//  Created by 孙硕磊 on 5/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "PageCollectionViewController.h"
@interface MyReceiptTableViewController : PageCollectionViewController
@property(nonatomic,assign) NSUInteger type;
-(void) reloadData;
@end
