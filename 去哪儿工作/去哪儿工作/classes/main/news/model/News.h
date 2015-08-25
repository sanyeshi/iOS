//
//  News.h
//  parttime
//
//  Created by 孙硕磊 on 4/19/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
@property(nonatomic,assign) NSUInteger  Id;
@property(nonatomic,copy)   NSString  * title;
@property(nonatomic,copy)   NSString  * imageUrlStr;
@property(nonatomic,copy)   NSString  * postTime;
@property(nonatomic,strong) NSArray   * items;
- (instancetype)initWithDict:(NSDictionary *) dict;
@end
