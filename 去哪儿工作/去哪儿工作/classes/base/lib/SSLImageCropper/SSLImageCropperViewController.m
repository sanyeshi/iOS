//
//  SSLImageCropperViewController.m
//  SSLImageCropper
//
//  Created by 孙硕磊 on 5/17/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "SSLImageCropperViewController.h"

#import "SSLAsset.h"
#import "SSLAssetCell.h"
#import "SSLAssetTablePicker.h"
#import "SSLAlbumPickerController.h"
#import <CoreLocation/CoreLocation.h>
#import <MobileCoreServices/UTCoreTypes.h>



@interface SSLImageCropperViewController ()

@end

@implementation SSLImageCropperViewController

- (instancetype)init
{
    SSLAlbumPickerController *albumPicker = [[SSLAlbumPickerController alloc] initWithStyle:UITableViewStylePlain];
    self = [super initWithRootViewController:albumPicker];
    if (self)
    {
        self.returnsOriginalImage = YES;
        self.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
    }
   return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.barStyle=UIBarStyleBlack;
    self.navigationBar.translucent=YES;
    self.navigationBar.barTintColor=GlobalNavigationBarColor;
    self.navigationBar.tintColor=GlobalNavigationBarTextColor;
}

- (SSLAlbumPickerController *)albumPicker
{
    return self.viewControllers[0];
}

- (void)setMediaTypes:(NSArray *)mediaTypes
{
    self.albumPicker.mediaTypes = mediaTypes;
}

- (NSArray *)mediaTypes
{
    return self.albumPicker.mediaTypes;
}


-(void) finishImageCropper
{
    [_imageCropperViewControllerDelegate sslImageCropperViewController:self didFinished:_croppedImage];
}
- (void)cancelImageCropper
{
    /*
    if ([_imageCropperViewControllerDelegate respondsToSelector:@selector(sslImageCropperViewControllerDidCancel:)])
    {
        [_imageCropperViewControllerDelegate performSelector:@selector(sslImageCropperViewControllerDidCancel:) withObject:self];
    }
     */
    
    /*
    if (_imageCropperViewControllerDelegate && [_imageCropperViewControllerDelegate conformsToProtocol:@protocol(SSLImageCropperViewControllerDelegate)] )
    {
        [_imageCropperViewControllerDelegate sslImageCropperViewControllerDidCancel:self];
    }
    */
    [_imageCropperViewControllerDelegate sslImageCropperViewControllerDidCancel:self];
}




@end
