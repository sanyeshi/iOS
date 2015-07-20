//
//  TicketViewController.m
//  线程
//
//  Created by 孙硕磊 on 7/7/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "TicketViewController.h"
#import "Ticket.h"

/*
   iOS中线程的方式
   1）NSObject对线程的支持；
   2）NSThread;
   3）NSOperation、NSOperationQueue；
   4）GCD
 
   iOS中线程同步控制的方式
   1）@synchronized
   2) NSLock
 */
@interface TicketViewController ()
{
    UITextView * _textView;
}
@end

@implementation TicketViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"卖票";
    self.view.backgroundColor=[UIColor whiteColor];
    //
    _textView=[[UITextView alloc] initWithFrame:self.view.frame];
    _textView.editable=NO;
    [self.view addSubview:_textView];
    
    //数据
    [Ticket sharedTicket].ticketNum=30;
    
    [self gcd];
}

-(void) appendText:(NSString *) text
{
    //1. 获取textView文本
    NSMutableString * str=[[NSMutableString alloc] initWithString:_textView.text];
    //2. 追加文本到textView中
    [str appendString:[NSString stringWithFormat:@"%@\n",text]];
    //3. 更新textView文本
    _textView.text=str;
    //4.使textView 滚动到文本底部
    NSRange  range=NSMakeRange(str.length-1, 1);
    [_textView scrollRangeToVisible:range];
}


-(void) sales:(NSString *) name
{
    while (true)
    {
        if ([name isEqualToString:@"gcd-1"])
        {
            [NSThread sleepForTimeInterval:1.0f];
        }
        else
        {
             [NSThread sleepForTimeInterval:0.2f];
        }

        //同步锁synchronized要锁的范围，对被抢夺的资源进行修改/读取的代码部分
        @synchronized(self)
        {
            if ([Ticket sharedTicket].ticketNum>0)
            {
                [Ticket sharedTicket].ticketNum--;
                NSString * text=[NSString stringWithFormat:@"剩余票数:%lu,线程:%@",[Ticket sharedTicket].ticketNum,name];
                //在主队列，更新界面
                dispatch_async(dispatch_get_main_queue(), ^{
                   [self appendText:text];
                });
            }
            else
            {
                break;
            }
            
        }
    }
}
#pragma mark  - gcd
-(void) gcd
{
    //1.获取全局队列
    dispatch_queue_t queue=dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0);
    //2.异步执行
    /*
    dispatch_async(queue, ^{
        [self sales:@"gcd-1"];
    });
    dispatch_async(queue, ^{
        [self sales:@"gcd-2"];
    });
     */
    
    //3. gcd可以将关联的操作，定义到一个群组中，定义到群组中之后，当所有线程执行完，可以获得通知
    //3.1 建立群组
    
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        [self sales:@"gcd-1"];
    });
    dispatch_group_async(group, queue, ^{
        [self sales:@"gcd-2"];
    });
    dispatch_group_async(group, queue, ^{
        [self sales:@"gcd-3"];
    });

    dispatch_group_notify(group, queue, ^{
        NSLog(@"售完!");
    });
    
    
}

@end
