//
//  Viwepager.h
//  parttime
//
//  Created by 孙硕磊 on 5/30/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kViewpagerHeight 200

@class SSLViwepager;

@protocol SSLViwepagerDelegate <NSObject>
-(void) sslViwepager:(SSLViwepager *) sslViwepager didSelectAtIndex:(NSInteger) index;
@end

@interface SSLViwepager : UIView<UIScrollViewDelegate>

@property(nonatomic,assign) id<SSLViwepagerDelegate> delegate;
- (instancetype)initWithModels:(NSArray *)models;
@end
