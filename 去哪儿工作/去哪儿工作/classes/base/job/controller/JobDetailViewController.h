//
//  JobDetailViewController.h
//  parttime
//
//  Created by 孙硕磊 on 4/5/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JobDetailView;
@class Job;
@interface JobDetailViewController : UIViewController

@property(nonatomic,strong) JobDetailView *jobDetailView;
@property(nonatomic,assign) NSUInteger    jobId;
@property(nonatomic,assign) BOOL          companyDetailViewControllerHidden;

- (instancetype)initWithJobId:(NSUInteger) jobId;
- (instancetype)initWithJob:(Job *) job;

@end
