//
//  WebViewController.h
//  WebView
//
//  Created by 孙硕磊 on 7/14/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CellItem;

@interface WebViewController : UIViewController
@property(nonatomic,strong) CellItem *cellItem;
@property(nonatomic,weak) UIWebView *webView;
@end
