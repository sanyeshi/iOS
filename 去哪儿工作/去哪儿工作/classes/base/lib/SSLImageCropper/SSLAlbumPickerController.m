//
//  AlbumPickerController.m
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import "SSLAlbumPickerController.h"
#import "SSLAssetTablePicker.h"
#import "SSLAlbumCell.h"
#import <MobileCoreServices/UTCoreTypes.h>


#import "SSLImageCropperViewController.h"

@interface SSLAlbumPickerController ()

@property (nonatomic, strong) ALAssetsLibrary *library;

@end

@implementation SSLAlbumPickerController

#pragma mark -视图加载

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	
    //设置导航栏标题
	[self.navigationItem setTitle:NSLocalizedString(@"加载中...", nil)];
    //导航栏右侧按钮
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self.parentViewController action:@selector(cancelImageCropper)];
    //图片册
    self.assetGroups =[[NSMutableArray alloc] init];
    self.library = [[ALAssetsLibrary alloc] init];

    //加载图片册
    dispatch_async(dispatch_get_main_queue(), ^
    {
        @autoreleasepool
        {
        
            // 遍历所有图片册
            void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop) 
            {
                if (group == nil)
                {
                    return;
                }
                //去除图片数等于0的图片册
                NSInteger gCount = [group numberOfAssets];
                if (gCount==0)
                {
                    [_assetGroups removeObject:group];
                    return;
                }

                //添加图像册，并调整camera roll顺序
                NSString *sGroupPropertyName = (NSString *)[group valueForProperty:ALAssetsGroupPropertyName];
                NSUInteger nType = [[group valueForProperty:ALAssetsGroupPropertyType] intValue];
                
                if ([[sGroupPropertyName lowercaseString] isEqualToString:@"camera roll"] && nType == ALAssetsGroupSavedPhotos)
                {
                    [self.assetGroups insertObject:group atIndex:0];
                }
                else
                {
                    [self.assetGroups addObject:group];
                }

                // 刷新表格
                [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
            };
            
            // 错误处理
            void (^assetGroupEnumberatorFailure)(NSError *) = ^(NSError *error)
            {
              
                if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied)
                {
                    NSString *errorMessage = NSLocalizedString(@"应用程序无法访问您的照片或视频，您可以在设置中更改访问权限。", nil);
                    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"拒绝访问", nil) message:errorMessage delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles:nil] show];
                  
                }
                else
                {
                    NSString *errorMessage = [NSString stringWithFormat:@"错误: %@ - %@", [error localizedDescription], [error localizedRecoverySuggestion]];
                    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"错误", nil) message:errorMessage delegate:nil cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles:nil] show];
                }
                [self.navigationItem setTitle:nil];
            };	
                    
            // 遍历图像册
            [self.library enumerateGroupsWithTypes:ALAssetsGroupAll
                                   usingBlock:assetGroupEnumerator 
                                 failureBlock:assetGroupEnumberatorFailure];
        
        }
    });
    
}

#pragma mark -视图即将出现或消失
- (void)viewWillAppear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:ALAssetsLibraryChangedNotification object:nil];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ALAssetsLibraryChangedNotification object:nil];
}

#pragma mark - 刷新表格
- (void)reloadTableView
{
	[self.tableView reloadData];
	[self.navigationItem setTitle:NSLocalizedString(@"照片", nil)];
}

#pragma mark - 过滤媒体类型
- (ALAssetsFilter *)assetFilter
{
    if([self.mediaTypes containsObject:(NSString *)kUTTypeImage] && [self.mediaTypes containsObject:(NSString *)kUTTypeMovie])
    {
        return [ALAssetsFilter allAssets];
    }
    else if([self.mediaTypes containsObject:(NSString *)kUTTypeMovie])
    {
        return [ALAssetsFilter allVideos];
    }
    else
    {
        return [ALAssetsFilter allPhotos];
    }
}

#pragma mark -表格数据源

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.assetGroups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SSLAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[SSLAlbumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //图片数量
    ALAssetsGroup *g = (ALAssetsGroup*)[self.assetGroups objectAtIndex:indexPath.row];
    [g setAssetsFilter:[self assetFilter]];
    NSInteger gCount = [g numberOfAssets];
    
    UIImage* image = [UIImage imageWithCGImage:[g posterImage]];
    //image = [self resize:image to:CGSizeMake(56, 56)];
    [cell.iconImageView setImage:image];

    cell.titleLabel.text = [NSString stringWithFormat:@"%@ (%ld)",[g valueForProperty:ALAssetsGroupPropertyName], (long)gCount];
   	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
    return cell;
}

#pragma mark -调整图片大小
- (UIImage *)resize:(UIImage *)image to:(CGSize)newSize
{
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark -表格代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	SSLAssetTablePicker *picker = [[SSLAssetTablePicker alloc] initWithNibName: nil bundle: nil];
    picker.assetGroup = [self.assetGroups objectAtIndex:indexPath.row];
    [picker.assetGroup setAssetsFilter:[self assetFilter]];
	picker.assetPickerFilterDelegate = self.assetPickerFilterDelegate;
	[self.navigationController pushViewController:picker animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kSSLAlbumCellHeight;
}

@end

