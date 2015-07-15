//
//  ViewController.m
//  网络
//
//  Created by 孙硕磊 on 7/14/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate>
{
    NSMutableData * requestData;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //并不会发生覆盖，自定义类型需要重写isEqual和hash方法
    /*
    NSDictionary * dict=@{@"aaaa":@"bbbbb",@"aaaa":@"bbbbbbbb",@"aa":@"vvvv"};
    
    for (NSString * key in dict.allKeys)
    {
        NSLog(@"(%@,%@)",key,[dict valueForKey:key]);
    }
     */
    requestData=[NSMutableData data];
    [self network];
}

#pragma mark -网络请求
/*
     网络请求的步骤:
     1)确定NSURL，也即确定所要请求的资源；
     2)建立请求;
     3)建立连接，并启动，等待网络处理(代理)；
     4)连接成功，处理结果
 */
-(void) network
{
    /*
    //确定url
    NSString * urlStr=@"http://pay.xywsc.com/parttime/headlines/list?cpage=1&pageSize=20";
    //若url包含中文，需要编码
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL * url=[NSURL URLWithString:urlStr];
    
    //建立请求,GET
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    //建立连接，并启动连接
    NSURLConnection * conn=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
     */
    
    
    /*
    //POST请求
    NSURL * url=[NSURL URLWithString:@"http://pay.xywsc.com/parttime/headlines/list"];
    NSMutableURLRequest * request=[[NSMutableURLRequest alloc] initWithURL:url];
    //默认为Get请求
    [request setHTTPMethod:@"POST"];
    //若参数有中文的话，此时不再需要编码，在转换为data的过程中已编码
    NSString * paras=@"cpage=1&pageSize=20";
    NSData   * data=[paras dataUsingEncoding:NSUTF8StringEncoding];
    //设置数据体
    [request setHTTPBody:data];
    //建立连接，并启动连接
    NSURLConnection * conn=[NSURLConnection connectionWithRequest:request delegate:self];
    [conn start];
     
    */
    
    
    /*
    NSURL * url=[NSURL URLWithString:@"http://pay.xywsc.com/parttime/headlines/list?cpage=1&pageSize=20"];
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    NSURLResponse * response=nil;
    NSError       * error=nil;
    //同步方法
    NSData * data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (data)
    {
        NSLog(@"response:%@",response);
        NSLog(@"data:%@",data);
    }
    else if (error)
    {
        NSLog(@"error:%@",[error localizedDescription]);
    }
     */
    
    
    /*
        异步方法
     */
    NSURL * url=[NSURL URLWithString:@"http://pay.xywsc.com/parttime/headlines/list?cpage=1&pageSize=20"];
    //在建立请求时，可以设置超时时间和缓存策略(内存缓存)
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         if(data)
         {
             [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
             NSLog(@"response:%@",response);
             NSLog(@"data:%@",data);
         }
         else if (data==nil&&connectionError==nil)
         {
             NSLog(@"empty data");
         }
         else if (connectionError)
         {
              NSLog(@"error:%@",[connectionError localizedDescription]);
         }

     }];
}

#pragma mark - 连接数据代理


#pragma mark 接收到响应(服务器准备传数据)，对于请求返回大量数据的话，会有多次响应
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse:%@",response);
}

#pragma mark 接收到数据，对于请求返回大量数据的话，会被调用多次，需要对每次传输的数据进行拼接
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"didReceiveData:%@",data);
    [requestData appendData:data];
}

#pragma mark 接收数据完成，对拼接后的数据做后续处理
-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"didFinishLoading,data:%@",requestData);
    //清空数据
    
}
#pragma mark 连接错误，网络环境异常复杂
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"连接错误:%@",error);
}


#pragma mark POST请求，向服务器发送数据
-(void) connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    NSLog(@"didSendBodyData");
}
@end
