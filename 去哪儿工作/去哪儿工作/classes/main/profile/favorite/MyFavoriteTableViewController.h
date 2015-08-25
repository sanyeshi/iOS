//
//  MyFavoriteViewController.h
//  parttime
//
//  Created by 孙硕磊 on 4/20/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "PageCollectionViewController.h"

@interface MyFavoriteTableViewController : PageCollectionViewController

@property(nonatomic,assign) MyFavoriteType myFavoriteType;
-(void) reloadData;

@end
