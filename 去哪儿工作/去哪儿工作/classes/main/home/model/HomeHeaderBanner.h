//
//  HomeTopBannerModel.h
//  parttime
//
//  Created by 孙硕磊 on 4/15/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeHeaderBanner : NSObject

@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * imageUrl;
@property(nonatomic,assign) NSUInteger jobId;

- (instancetype)initWithDict:(NSDictionary *) dict;
@end
