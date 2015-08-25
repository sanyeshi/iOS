//
//  SSLViwepagerModel.h
//  parttime
//
//  Created by 孙硕磊 on 5/30/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSLViwepagerModel : NSObject

@property(nonatomic,copy)   NSString * title;
@property(nonatomic,copy)   NSString * imageUrlStr;

+(instancetype) sslViwepagerModelWithTitle:(NSString *) title imageUrlStr:(NSString *) imageUrlStr;

@end
