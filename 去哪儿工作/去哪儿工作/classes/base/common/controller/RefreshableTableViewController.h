//
//  RefreshableTableViewController.h
//  parttime
//
//  Created by 孙硕磊 on 4/19/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    FooterRefreshStateIdle = 1,        // 普通闲置状态
    FooterRefreshStateRefreshing,      // 正在刷新中的状态
    FooterRefreshStateNoMoreData       // 所有数据加载完毕，没有更多的数据了
} FooterRefreshState;

@interface RefreshableTableViewController : UITableViewController
//刷新控件及其相关方法
-(void) loadHeaderRefreshControl;
-(void) loadFooterRefreshControl;
-(void) didHeaderRefresh;
-(void) didFooterRefresh;
-(void) beginHeaderRefreshing;
-(void) beginFooterRefreshing;
-(void) endHeaderRefreshing;
-(void) endFooterRefreshing;
-(void) endRefreshing;
-(void) setFooterTitle:(NSString *) title forState:(FooterRefreshState) state;
-(void) setFooterEnabled:(BOOL) enabled;
@end
