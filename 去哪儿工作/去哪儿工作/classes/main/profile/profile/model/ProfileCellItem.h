//
//  ProfileCellItem.h
//  parttime
//
//  Created by 孙硕磊 on 5/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProfileCellItem : NSObject
@property(nonatomic,copy) NSString * iconName;
@property(nonatomic,copy) NSString * title;
@property(nonatomic,strong) Class  willShowViewControllerClass;

- (instancetype)initWithIconName:(NSString *) iconName title:(NSString *) title willShowViewControllerClass:(Class) class;
@end
