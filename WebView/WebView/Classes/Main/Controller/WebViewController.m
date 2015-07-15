//
//  WebViewController.m
//  WebView
//
//  Created by 孙硕磊 on 7/14/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "WebViewController.h"
#import "CellItem.h"

@interface WebViewController ()<UIWebViewDelegate>

@end

@implementation WebViewController

-(void) loadView
{
    UIWebView * webView=[[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    webView.delegate=self;
    self.view=webView;
    self.webView=webView;
}

/*
    本地应用+Web App混合开发，如新闻类的页面可以采用加载网页形式
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=self.cellItem.title;
    self.view.backgroundColor=[UIColor whiteColor];
    
    //在iOS中NSURL既可以表示网络资源，也可以表示本地资源
    //UIWebView可以使用URL加载资源，也可以使用本地文件路径加载本地资源，不过没有使用NSURL方便,而且本地Doc文件并不能通过本地路径加载
    //NSURL * url=[NSURL URLWithString:@"http://m.baidu.com/"];
    //[self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    //  [self.webView loadRequest:[NSURLRequest requestWithURL:self.cellItem.url]];

    NSBundle * mainBundle=[NSBundle mainBundle];
    
    /*
    NSString * path=[mainBundle pathForResource:@"关于" ofType:@"txt"];
    NSString * mime=@"text/plain";
     */

    /*
    NSString * path=[mainBundle pathForResource:@"iOS6Cookbook" ofType:@"pdf"];
    NSString * mime=@"application/pdf";
     */
    
    /*
    NSString * path=[mainBundle pathForResource:@"demo" ofType:@"html"];
    NSString * mime=@"text/html";
    [self loadLocalResourceWithMIME:mime path:path];
     */
    
    /*
       显示本地的HTML字符串
     */
    NSString * htmlStr=@"<h1>标题<h1>";
    [self.webView loadHTMLString:htmlStr baseURL:nil];
    
}


/*
     webView加载本地文件可以使用加载数据的方式:
     1.使用NSData加载本地数据；
     2.指定资源类型MIME；
     3.编码格式字符串
     4.相对地址，加载本地文件不使用
 */
-(void) loadLocalResourceWithMIME:(NSString *) mime path:(NSString *) path
{
    NSData * data=[NSData dataWithContentsOfFile:path];
    //检测所有类型
    [self.webView setDataDetectorTypes:UIDataDetectorTypeAll];
    [self.webView loadData:data MIMEType:mime textEncodingName:@"UTF-8" baseURL:nil];
}


/*
   获取资源类型
 */
-(NSString *) mime:(NSURL *) url
{
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    NSURLResponse *response=nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    return response.MIMEType;
}

-(void) webViewDidStartLoad:(UIWebView *)webView
{
    
}

-(void) webViewDidFinishLoad:(UIWebView *)webView
{
    //js代码代码只有在页面加载完毕后才能执行
    NSString * js=@"alert('hello world')";
    [_webView stringByEvaluatingJavaScriptFromString:js];
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}
@end
