//
//  TextFieldCell.h
//  parttime
//
//  Created by 孙硕磊 on 4/24/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TextFieldModel;


@interface TextFieldCell : UITableViewCell
@property(nonatomic,assign) CGFloat         leftLabelWidth;
@property(nonatomic,strong) UITextField   * textField;
@property(nonatomic,strong) UILabel       * leftLabel;
@property(nonatomic,strong) TextFieldModel* textFieldModel;
@end
