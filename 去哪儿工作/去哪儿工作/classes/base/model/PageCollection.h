//
//  PageCollection.h
//  parttime
//
//  Created by 孙硕磊 on 4/18/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageCollection : NSObject

@property(nonatomic,assign) NSUInteger       recordCount;
@property(nonatomic,assign) NSUInteger       pageCount;
@property(nonatomic,assign) NSUInteger       pageSize;
@property(nonatomic,assign) NSUInteger       currentPage;
@property(nonatomic,assign) NSUInteger       prePage;
@property(nonatomic,assign) NSUInteger       nextPage;
@property(nonatomic,assign) BOOL             hasPrePage;
@property(nonatomic,assign) BOOL             hasNextPage;
@property(nonatomic,strong) NSMutableArray * array;

-(void) parsePageCollectionWithDict:(NSDictionary *) dict;
@end
