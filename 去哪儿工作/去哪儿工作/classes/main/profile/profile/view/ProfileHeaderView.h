//
//  ProfileHeaderView.h
//  parttime
//
//  Created by 孙硕磊 on 4/6/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kProfileHeaderViewHeight 200
@class MultiTextLabel;
@class ProfileHeaderView;

@protocol ProfileHeaderViewDelegate <NSObject>
-(void) profileHeaderView:(ProfileHeaderView *) profileHeaderView didSelectedAtIndex:(NSUInteger) index;
@end

@interface ProfileHeaderView : UIView
@property(nonatomic,strong) UIImageView      *iconImageView;   //用户头像视图
@property(nonatomic,strong) UILabel          *nameLabel;       //用户名称视图
@property(nonatomic,strong) MultiTextLabel   *pointValueLabel; //积分
@property(nonatomic,strong) MultiTextLabel   *moneyLabel;      //金额

@property(nonatomic,assign) id<ProfileHeaderViewDelegate> profileHeaderViewDelegate;
@end
