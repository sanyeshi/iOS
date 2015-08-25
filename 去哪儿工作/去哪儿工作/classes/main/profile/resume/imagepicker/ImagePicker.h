//
//  ImagePicker.h
//  parttime
//
//  Created by 孙硕磊 on 5/18/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImagePicker;

@protocol ImagePickerDelegate <NSObject>
-(void) imagePicker:(ImagePicker *) imagePicker didFinishPickingWithSelectedIndexs:(NSSet *) selectedIndexs;
-(void) imagePickerDidCancel;
@end

@interface ImagePicker : UIViewController

@property(nonatomic,strong) NSArray  * imageUrlStrs;
@property(nonatomic,assign) id<ImagePickerDelegate> delegate;

@end
