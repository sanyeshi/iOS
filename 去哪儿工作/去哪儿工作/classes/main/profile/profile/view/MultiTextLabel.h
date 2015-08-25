//
//  MultiTextLabel.h
//  parttime
//
//  Created by 孙硕磊 on 3/27/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMultilTextLabelTitleLableHeight 20
#define kMultilTextLabelSubTitleLabelHeight 12
#define kMultiTextMargin 2
#define kMultilTextLabelHeight 34

@interface MultiTextLabel : UIView
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *subTitleLabel;
@end
