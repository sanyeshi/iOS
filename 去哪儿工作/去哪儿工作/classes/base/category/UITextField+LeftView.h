//
//  UITextField+LeftView.h
//  parttime
//
//  Created by 孙硕磊 on 5/12/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LeftView)
+(UITextField *) textFieldWithLeftViewImageName:(NSString *) imageName placeholder:(NSString *) placeholder;
+(UITextField *) textFieldWithTitle:(NSString *) title placeholder:(NSString *) placeholder;
@end
