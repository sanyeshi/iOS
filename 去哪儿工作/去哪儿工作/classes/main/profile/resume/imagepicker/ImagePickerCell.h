//
//  ImagePickerCell.h
//  parttime
//
//  Created by 孙硕磊 on 5/18/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kMargin        2

#define kImagePickerCellWidth (iPhone5==YES?77:(iPhone6==YES?91:80))
#define kImagePickerCellHeight 80

@class ImagePickerCell;

@protocol ImagePickCellDelegate <NSObject>

-(void) imagePickerCell:(ImagePickerCell *) imagePickerCell didSelectedAtIndexPath:(NSIndexPath *) indexPath;

@end

@interface ImagePickerCell : UICollectionViewCell

@property(nonatomic,assign,readonly)  BOOL    isSelected;
@property(nonatomic,strong) NSIndexPath    *  indexPath;
@property(nonatomic,strong) UIImageView    *  coverImageView;
@property(nonatomic,strong) UIImageView    *  imageView;

@property(nonatomic,assign) id<ImagePickCellDelegate> delegate;

@end
