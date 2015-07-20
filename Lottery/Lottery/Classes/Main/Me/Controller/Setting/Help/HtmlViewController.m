//
//  HtmlViewController.m
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "HtmlViewController.h"
#import "HtmlModel.h"


@interface HtmlViewController ()<UIWebViewDelegate>

@end

@implementation HtmlViewController

-(void) loadView
{
    UIWebView * webView=[[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view=webView;
    webView.delegate=self;
    _webView=webView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=_htmlModel.title;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
    
    //加载网页
    NSURL * url=[[NSBundle mainBundle] URLForResource:_htmlModel.htmlName withExtension:nil];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}


-(void) close:(UIBarButtonItem *) barButtonItem
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void) webViewDidStartLoad:(UIWebView *)webView
{
    
}

#warning 执行js代码
-(void) webViewDidFinishLoad:(UIWebView *)webView
{
    //执行js代码
    if(_htmlModel.ID)
    {
        NSString * js=[NSString stringWithFormat:@"window.location.href='#%@';",_htmlModel.ID];
        [webView stringByEvaluatingJavaScriptFromString:js];
    }
    
}


@end
