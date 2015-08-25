//
//  CheckCodeButton.m
//  parttime
//
//  Created by 孙硕磊 on 4/27/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "CheckCodeButton.h"

#define kSeconds 60
static int SECONDS=0;

@interface CheckCodeButton ()
{
    UIColor * _originalBackgroundColor;
}
@end
@implementation CheckCodeButton
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addTarget:self action:@selector(sendCheckCode:) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

-(void) setCheckCodeStyleForState:(CheckCodeState)checkCodeState
{
    if (checkCodeState==CheckCodeStateNormal)
    {
        [self setUserInteractionEnabled:YES];
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self setTitleColor:_titleColor forState:UIControlStateNormal];
        if (_originalBackgroundColor)
        {
            [self setBackgroundColor:_originalBackgroundColor];
        }
        self.titleLabel.font=_titleFont;
        //self.frame=CGRectMake(10,(self.frame.size.height-20)*0.5, 80,20);
        if (_hasBorder)
        {
            self.layer.borderColor=[_borderColor CGColor];
            self.layer.borderWidth=_borderWidth;
            self.layer.cornerRadius=_cornerRadius;
        }
    }
    else if(checkCodeState==CheckCodeStateBeginSending)
    {
        [self setUserInteractionEnabled:NO];
        [self setTitle:[NSString stringWithFormat:@"再次获取%d秒",SECONDS] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _originalBackgroundColor=self.backgroundColor;
        [self setBackgroundColor:[UIColor lightGrayColor]];
    }
    else if(checkCodeState==CheckCodeButtonEndSending)
    {
        [self setUserInteractionEnabled:YES];
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self setTitleColor:_titleColor forState:UIControlStateNormal];
        [self setBackgroundColor:_originalBackgroundColor];
    }
}


#pragma mark -获取验证码
-(void) sendCheckCode:(CheckCodeButton *) button
{
    if (_sendCheckCodeBlock)
    {
        _sendCheckCodeBlock();
    }
    if (SECONDS!=0)
    {
        return;
    }
    SECONDS=kSeconds;
    [self updateCheckCodeButton:button];
}

-(void) updateCheckCodeButton:(CheckCodeButton *) button
{
    [button setCheckCodeStyleForState:CheckCodeStateBeginSending];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod:) userInfo:button repeats:YES];
    
}

-(void)timeFireMethod:(NSTimer *) timer
{
    //倒计时
    CheckCodeButton *button=(CheckCodeButton *)timer.userInfo;
    SECONDS--;
    [button setTitle:[NSString stringWithFormat:@"再次获取%d秒",SECONDS] forState:UIControlStateNormal];
    if(SECONDS==0)
    {
        [timer invalidate];
        [button setCheckCodeStyleForState:CheckCodeButtonEndSending];
    }
}

@end
