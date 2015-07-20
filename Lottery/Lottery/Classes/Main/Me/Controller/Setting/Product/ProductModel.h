//
//  ProductModel.h
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject
@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * ID;
@property(nonatomic,copy) NSString * url;
@property(nonatomic,copy) NSString * icon;
@property(nonatomic,copy) NSString * customUrl;

+(instancetype) productModelWithDict:(NSDictionary *) dict;

@end
