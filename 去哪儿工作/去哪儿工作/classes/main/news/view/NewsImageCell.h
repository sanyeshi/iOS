//
//  InfoCell.h
//  parttime
//
//  Created by 孙硕磊 on 3/28/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kNewsImageCellHeight 231

@interface NewsImageCell : UITableViewCell
@property(nonatomic,strong) UIImageView * newsImageView;
@property(nonatomic,strong) UILabel     * newsTitleLabel;
@end
