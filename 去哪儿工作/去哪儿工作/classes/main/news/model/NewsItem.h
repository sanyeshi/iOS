//
//  NewsItem.h
//  parttime
//
//  Created by 孙硕磊 on 4/19/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject
@property(nonatomic,copy) NSString * content;
@property(nonatomic,copy) NSString * imageUrlStr;
- (instancetype)initWithDict:(NSDictionary *) dict;
@end
