//
//  RootViewController.m
//  SSLImageCropper
//
//  Created by 孙硕磊 on 5/17/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "RootViewController.h"

#import "SSLImageCropperViewController.h"


@interface RootViewController ()<SSLImageCropperViewControllerDelegate>
{
    UIImageView* _imageView;
}
@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton * button=[[UIButton alloc] init];
    button.frame=CGRectMake(100, 100, 100, 20);
    button.backgroundColor=[UIColor redColor];
    [button setTitle:@"照片裁剪" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(imageCropper:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
    
    
    UIImageView * imageView=[[UIImageView alloc] init];
    imageView.frame=CGRectMake(0, 150, self.view.frame.size.width, 300);
    [self.view addSubview:imageView];
    _imageView=imageView;
    
}

-(void) imageCropper:(UIButton *) button
{
    [self pickImage];
}


#pragma mark - 选取本地图片
- (void) pickImage
{
    SSLImageCropperViewController * imageCropper=[[SSLImageCropperViewController alloc] init];
    imageCropper.imageCropperViewControllerDelegate=self;
    [self presentViewController:imageCropper animated:YES completion:nil];
}

-(void) sslImageCropperViewController:(SSLImageCropperViewController *)cropper didFinished:(UIImage *)croppedImage
{
    
     _imageView.image=croppedImage;
    [self dismissViewControllerAnimated:YES completion:^
    {
       
    }];
}
-(void) sslImageCropperViewControllerDidCancel:(SSLImageCropperViewController *)cropper
{
     [self dismissViewControllerAnimated:YES completion:nil];
}

@end
