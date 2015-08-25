//
//  CheckCodeButton.h
//  parttime
//
//  Created by 孙硕磊 on 4/27/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger
{
    CheckCodeStateNormal,
    CheckCodeStateBeginSending,
    CheckCodeButtonEndSending
} CheckCodeState;

typedef void(^SendCheckCodeBlock)();

@interface CheckCodeButton : UIButton

@property(nonatomic,strong)  UIFont   * titleFont;
@property(nonatomic,strong)  UIColor * titleColor;
@property(nonatomic,assign)  BOOL      hasBorder;
@property(nonatomic,assign)  CGFloat   borderWidth;
@property(nonatomic,assign)  CGFloat   cornerRadius;
@property(nonatomic,strong)  UIColor * borderColor;

@property(nonatomic,copy)    SendCheckCodeBlock  sendCheckCodeBlock;

-(void) setCheckCodeStyleForState:(CheckCodeState) checkCodeState;
@end
