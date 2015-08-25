//
//  TextField.h
//  parttime
//
//  Created by 孙硕磊 on 4/27/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger
{
    TextFieldKeyBoardTypeDefault,
    TextFieldKeyBoardTypeDate,
    TextFieldKeyBoardTypeAge,
    TextFieldKeyBoardTypeGender,
    TextFieldKeyBoardTypePhone,
    TextFieldKeyBoardTypeEmail,
    TextFieldKeyBoardTypeNumber
} TextFieldKeyBoardType;

@interface TextFieldModel : NSObject
@property(nonatomic,assign)  BOOL         isEditable;
@property(nonatomic,copy)    NSString   * title;
@property(nonatomic,copy)    NSString   * content;
@property(nonatomic,copy)    NSString   * placeholder;
@property(nonatomic,assign)  TextFieldKeyBoardType keyboardType;

- (instancetype)initWithTitle:(NSString *) title  keyboardType:(TextFieldKeyBoardType) keyboardType;
- (instancetype)initWithTitle:(NSString *) title  content:(NSString *) content keyboardType:(TextFieldKeyBoardType) keyboardType;
@end
