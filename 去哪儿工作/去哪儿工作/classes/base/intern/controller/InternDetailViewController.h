//
//  JobDetailViewController.h
//  parttime
//
//  Created by 孙硕磊 on 4/5/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InternDetailView;
@class Intern;

@interface InternDetailViewController : UIViewController
@property(nonatomic,strong) InternDetailView *internDetailView;
@property(nonatomic,assign) NSUInteger       internId;
@property(nonatomic,assign) BOOL             companyDetailViewControllerHidden;

- (instancetype)initWithInternId:(NSUInteger)internId;
- (instancetype)initWithIntern:(Intern *) intern;
@end
