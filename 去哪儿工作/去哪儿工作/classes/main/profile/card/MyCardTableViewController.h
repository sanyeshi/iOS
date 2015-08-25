//
//  MyCardViewController.h
//  parttime
//
//  Created by 孙硕磊 on 4/20/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "Http.h"
#import "PageCollectionViewController.h"

@interface MyCardTableViewController : PageCollectionViewController
@property(nonatomic,assign)MyCardType myCardType;
-(void) reloadData;
@end
