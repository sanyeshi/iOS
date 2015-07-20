//
//  HtmlViewController.h
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "BaseViewController.h"
@class HtmlModel;

@interface HtmlViewController : BaseViewController
@property(nonatomic,strong) HtmlModel *htmlModel;
@property(nonatomic,weak,readonly) UIWebView *webView;
@end
