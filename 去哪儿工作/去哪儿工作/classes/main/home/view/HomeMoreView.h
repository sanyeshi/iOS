//
//  HomeMoreView.h
//  parttime
//
//  Created by 孙硕磊 on 3/29/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeMoreView;

@protocol HomeMoreViewDelegate <NSObject>
-(void) homeMoreView:(HomeMoreView *)homeMoreView didSelectedItemIndex:(NSInteger)index;
@end

@interface HomeMoreView : UIView
@property(nonatomic,assign) id<HomeMoreViewDelegate> delegate;
-(void) show;
-(void) hide;
-(void) hideWithAnimation;
@end
