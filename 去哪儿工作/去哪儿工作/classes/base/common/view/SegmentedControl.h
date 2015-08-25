//
//  SegmentedControl.h
//  parttime
//
//  Created by 孙硕磊 on 5/12/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SegmentedControl;

@protocol SegmentedControlDelegate <NSObject>
- (void)segmentedControl:(SegmentedControl *)segmentedControl clickedItemAtIndex:(NSInteger)itemIndex;
@end

@interface SegmentedControl : UIView

@property(nonatomic,assign) NSInteger    selectedSegmentIndex;

@property(nonatomic,assign) id<SegmentedControlDelegate> delegate;
- (instancetype)initWithItems:(NSArray *)items;
@end
