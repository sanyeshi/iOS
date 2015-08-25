//
//  CategoryHeaderView.h
//  parttime
//
//  Created by 孙硕磊 on 4/6/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCategoryHeaderViewHeight 40.0f

typedef enum : NSUInteger
{
    CategoryTypeParttimeJob,
    CategoryTypeInternship
}CategoryType;

@class CategoryHeaderView;
@protocol CategoryHeaderViewDelegate  <NSObject>
-(void) categoryHeaderView:(CategoryHeaderView *) categoryHeaderView didSelectSection:(NSUInteger)section;
-(void) categoryHeaderView:(CategoryHeaderView *) categoryHeaderView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface CategoryHeaderView : UIView

@property(nonatomic,strong) NSArray        *jobAllTypeArray;
@property(nonatomic,strong) NSArray        *internAllTypeArray;
@property(nonatomic,strong) NSArray        *orderAllTypeArray;

@property(nonatomic,strong) UIButton       * allTypeButton;
@property(nonatomic,strong) UIButton       * orderTypeButton;
@property(nonatomic,strong) UIScrollView   * popupListView;

@property(nonatomic,assign) NSUInteger       selectedSection;
@property(nonatomic,assign) CategoryType     categoryType;
@property(nonatomic,assign) id<CategoryHeaderViewDelegate> delegate;


-(void) showPopupListView;
-(void) removePopupListView;
-(void) removePopupListViewWithAnimationCompletion:(void(^)(BOOL finished))completion;
@end
