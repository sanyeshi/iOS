//
//  JobCommentCell.h
//  parttime
//
//  Created by 孙硕磊 on 4/5/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "SeparatorCell.h"
#define kCommentCellHeight 45

@class CompanyComment;

@interface CompanyCommentCell : SeparatorCell
@property(nonatomic,strong) UILabel  * commenterNameLabel;
@property(nonatomic,strong) UILabel  * dateLabel;
@property(nonatomic,strong) UILabel  * commentLabel;

-(void) setCompanyComment:(CompanyComment *) comment;
@end
