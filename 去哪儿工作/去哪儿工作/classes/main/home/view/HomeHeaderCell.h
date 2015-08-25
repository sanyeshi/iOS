//
//  HomeHeaderCell.h
//  parttime
//
//  Created by 孙硕磊 on 3/29/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kHomeHeaderCellHeight 200

@class HomeHeaderCell;

@protocol HomeHeaderCellDelegate <NSObject>
-(void) homeHeaderCell:(HomeHeaderCell *) homeHeaderCell didSelectAtIndex:(NSInteger) index;
@end

@interface HomeHeaderCell : UITableViewCell<UIScrollViewDelegate>

@property(nonatomic,assign) id<HomeHeaderCellDelegate> homeHeaderCellDelegate;
- (instancetype)initWithModels:(NSArray *)models;
@end
