//
//  SSLImageCropperViewController.h
//  SSLImageCropper
//
//  Created by 孙硕磊 on 5/17/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SSLImageCropperViewController;

@protocol SSLImageCropperViewControllerDelegate
-(void) sslImageCropperViewController:(SSLImageCropperViewController *) cropper  didFinished:(UIImage *)croppedImage;
-(void) sslImageCropperViewControllerDidCancel:(SSLImageCropperViewController *) cropper;
@end


@interface SSLImageCropperViewController : UINavigationController

@property(nonatomic,assign) id<SSLImageCropperViewControllerDelegate> imageCropperViewControllerDelegate;

@property(nonatomic,strong)    UIImage  * croppedImage;
@property (nonatomic, strong)  NSArray  * mediaTypes;
@property (nonatomic, assign)  BOOL       returnsOriginalImage;
-(void) finishImageCropper;
-(void)cancelImageCropper;
@end
