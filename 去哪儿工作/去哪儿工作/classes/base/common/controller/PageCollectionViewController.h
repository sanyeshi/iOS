//
//  PageCollectionViewController.h
//  parttime
//
//  Created by 孙硕磊 on 5/4/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "RefreshableTableViewController.h"
@class PageCollection;

@interface PageCollectionViewController : RefreshableTableViewController
@property(nonatomic,strong) PageCollection * pageCollection;
-(void) requestData:(PageCollection *)pageCollection;          //请求数据
@end
