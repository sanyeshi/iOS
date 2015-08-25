//
//  ShowCell.h
//  parttime
//
//  Created by 孙硕磊 on 4/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMargin        2

#define kShowCellWidth (iPhone5==YES?77:(iPhone6==YES?91:80))
#define kShowCellHeight 60

@interface ShowCell : UICollectionViewCell
@property(nonatomic,strong) UIImageView *imageView;
@end
