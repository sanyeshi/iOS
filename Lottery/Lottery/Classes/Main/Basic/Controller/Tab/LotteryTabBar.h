//
//  AppTabBar.h
//  lottery
//
//  Created by 孙硕磊 on 4/15/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LotteryTabBar;

@protocol LotteryTabBarDelegate <NSObject>
-(void) lotteryTabBar:(LotteryTabBar *) lotteryTabBar didClickedTabBarButtonAtIndex:(NSUInteger)index;
@end

@interface LotteryTabBar : UIView
@property(nonatomic,assign) id<LotteryTabBarDelegate> delegate;
@property(nonatomic,assign) NSUInteger defaultIndex;
@end
