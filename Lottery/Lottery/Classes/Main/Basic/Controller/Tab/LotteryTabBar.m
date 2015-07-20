//
//  AppTabBar.m
//  lottery
//
//  Created by 孙硕磊 on 4/15/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "LotteryTabBar.h"
#import "LotteryTabBarButton.h"

#define kTabBarButtonCount 5

@interface LotteryTabBar ()
{
    NSUInteger  _selectedIndex;
}
@end

@implementation LotteryTabBar
- (instancetype)init
{
    self = [super init];
    if (self)
    {
       self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"TabBarBack.png"]];
      [self createTabBarButtons];
    }
    return self;
}

-(void) createTabBarButtons
{
    for (int i=0;i<kTabBarButtonCount; i++)
    {
        LotteryTabBarButton * tabBarButton=[LotteryTabBarButton buttonWithType:UIButtonTypeCustom];
        [tabBarButton setTag:i];
        [tabBarButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"TabBar%d.png",i+1]] forState:UIControlStateNormal];
        [tabBarButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"TabBar%dSel.png",i+1]] forState:UIControlStateSelected];
        [tabBarButton addTarget:self action:@selector(didClickedTabBarButton:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:tabBarButton];
    }
}


-(void) setDefaultIndex:(NSUInteger)defaultIndex
{
    _defaultIndex=defaultIndex;
    [self  didClickedTabBarButton:self.subviews[defaultIndex]];
}

-(void) layoutSubviews
{
    CGFloat tabBarButtonWidth=self.frame.size.width/kTabBarButtonCount;
    CGFloat tabBarButtonHeight=self.frame.size.height;
    NSArray * tabBarButtons=self.subviews;
    for (int i=0; i<kTabBarButtonCount; i++)
    {
        LotteryTabBarButton * tabBarButton=tabBarButtons[i];
        tabBarButton.frame=CGRectMake(i*tabBarButtonWidth, 0, tabBarButtonWidth, tabBarButtonHeight);
    }
}

#pragma mark -- 点击按钮切换视图控制器
-(void) didClickedTabBarButton:(LotteryTabBarButton *) tabBarButton
{
    //更新选中状态
    LotteryTabBarButton * lastSelectedTabBarButton=(LotteryTabBarButton *)self.subviews[_selectedIndex];
    [lastSelectedTabBarButton setSelected:NO];
    _selectedIndex=tabBarButton.tag;
    [tabBarButton setSelected:YES];
   
    if (_delegate&& [_delegate conformsToProtocol:@protocol(LotteryTabBarDelegate)])
    {
        [_delegate lotteryTabBar:self didClickedTabBarButtonAtIndex:tabBarButton.tag];
    }
}
@end
