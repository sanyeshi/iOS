//
//  NewsDetailViewController.m
//  parttime
//
//  Created by 孙硕磊 on 5/4/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "NewsDetailView.h"
#import "News.h"
#import "NewsItem.h"
#import "UIImageView+WebCache.h"

#define kMargin 10
#define kMargin_2 5
@implementation NewsDetailView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

-(void) setNews:(News *)news
{
    _news=news;
    //标题
    CGFloat x=kMargin;
    CGFloat y=kMargin;
    CGFloat w=self.frame.size.width-2*kMargin;
    CGFloat h=0;
    self.titleLabel=[[UILabel alloc] init];
    _titleLabel.font=GlobalBigBoldFont;
    _titleLabel.textColor=GlobalBlackTextColor;
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    _titleLabel.frame=CGRectMake(x, y, w,20);
    _titleLabel.text=news.title;
    [self addSubview:_titleLabel];
     h=y+_titleLabel.frame.size.height;
    //时间
    y=h;
    self.dateLabel=[[UILabel alloc] init];
    _dateLabel.font=GlobalFont;
    _dateLabel.textColor=GlobalBackgroundTextColor;
    _dateLabel.textAlignment=NSTextAlignmentRight;
    _dateLabel.frame=CGRectMake(x, y, w, 20);
    _dateLabel.text=news.postTime;
    [self addSubview:_dateLabel];
    h=y+_dateLabel.frame.size.height;

    //详情
    NSArray *newsItems=news.items;
    for (int i=0; i<newsItems.count; i++)
    {
        NewsItem * newsItem=newsItems[i];
        if(newsItem.imageUrlStr)
        {
            y=h+kMargin;
            UIImageView * imageView=[[UIImageView alloc] init];
            [imageView sd_setImageWithURL:[NSURL URLWithString:newsItem.imageUrlStr] placeholderImage:[[UIImage alloc] init]];
            imageView.contentMode=UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds=YES;
            imageView.frame=CGRectMake(x,y, w, 120);
            [self addSubview:imageView];
            h=y+imageView.frame.size.height;
        }
        if (newsItem.content)
        {
            y=h+kMargin_2;
            UITextView * textView=[[UITextView alloc] init];
            textView.attributedText=[self attributedString:newsItem.content];
            textView.bounces=NO;
            textView.scrollEnabled=NO;
            textView.editable=NO;
            CGSize  size=[textView sizeThatFits:CGSizeMake(w, MAXFLOAT)];
            textView.frame=CGRectMake(x, y, w, size.height);
            [self addSubview:textView];
            h=y+size.height;

        }
    }
    self.contentSize=CGSizeMake(w, h+kMargin);
}
 #pragma mark - 富文本字符串
 -(NSMutableAttributedString *) attributedString:(NSString *) string
 {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    //[paragraphStyle setFirstLineHeadIndent:24.0f];
    [attributedString addAttribute:NSForegroundColorAttributeName value:GlobalBlackTextColor range:NSMakeRange(0,[string length])];
    [attributedString addAttribute:NSFontAttributeName value:GlobalFont range:NSMakeRange(0,[string length])];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,[string length])];
    return attributedString;
}



@end
