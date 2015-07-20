//
//  HtmlModel.h
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HtmlModel : NSObject
@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * htmlName;
@property(nonatomic,copy) NSString * ID;

+(instancetype) htmlModelWithDict:(NSDictionary *) dict;
@end
