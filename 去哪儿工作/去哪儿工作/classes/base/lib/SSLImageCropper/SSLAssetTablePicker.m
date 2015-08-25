//
//  ELCAssetTablePicker.m
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import "SSLAssetTablePicker.h"
#import "SSLAssetCell.h"
#import "SSLAsset.h"
#import "SSLAlbumPickerController.h"
#import "SSLImageCropper.h"

#import "SSLImageCropperViewController.h"
#import "VPImageCropperViewController.h"

@interface SSLAssetTablePicker ()<VPImageCropperDelegate,UINavigationControllerDelegate>
{
    int               _columns;
}
@end

@implementation SSLAssetTablePicker

- (id)init
{
    self = [super init];
    if (self)
    {
        //Sets a reasonable default bigger then 0 for columns
        //So that we don't have a divide by 0 scenario
        _columns=kELCAssetItemCount;
    }
    return self;
}
#pragma mark -视图加载完毕
- (void)viewDidLoad
{
    [super viewDidLoad];
    //表格
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.tableView setAllowsSelection:NO];
    //
    self.sslAssets =[[NSMutableArray alloc] init];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    [self.navigationItem setTitle:NSLocalizedString(@"加载中...", nil)];
    
    //准备图片
	[self performSelectorInBackground:@selector(preparePhotos) withObject:nil];
    
    // Register for notifications when the photo library has changed
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preparePhotos) name:ALAssetsLibraryChangedNotification object:nil];
}

#pragma mark - 视图即将出现、消失
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _columns=kELCAssetItemCount;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ALAssetsLibraryChangedNotification object:nil];
}

/*
#pragma mark -设备旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    self.columns = self.view.bounds.size.width / 80;
    [self.tableView reloadData];
}
*/

#pragma mark -准备图片
- (void)preparePhotos
{
    @autoreleasepool
    {
        
        [self.sslAssets removeAllObjects];
        [self.assetGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop)
        {
            
            if (result == nil)
            {
                return;
            }
            
            SSLAsset *sslAsset = [[SSLAsset alloc] initWithAsset:result];
            BOOL isAssetFiltered = NO;
            if (self.assetPickerFilterDelegate &&
               [self.assetPickerFilterDelegate respondsToSelector:@selector(assetTablePicker:isAssetFilteredOut:)])
            {
                isAssetFiltered = [self.assetPickerFilterDelegate assetTablePicker:self isAssetFilteredOut:(SSLAsset*)sslAsset];
            }

            if (!isAssetFiltered)
            {
                [self.sslAssets addObject:sslAsset];
            }

         }];

        dispatch_sync(dispatch_get_main_queue(), ^
        {
            [self.tableView reloadData];
            // 滑动到底部
            long section = [self numberOfSectionsInTableView:self.tableView] - 1;
            long row = [self tableView:self.tableView numberOfRowsInSection:section] - 1;
            if (section >= 0 && row >= 0)
            {
                NSIndexPath *ip = [NSIndexPath indexPathForRow:row
                                                     inSection:section];
                        [self.tableView scrollToRowAtIndexPath:ip
                                              atScrollPosition:UITableViewScrollPositionBottom
                                                      animated:NO];
            }
            //显示标题
            NSString *sGroupPropertyName = (NSString *)[_assetGroup valueForProperty:ALAssetsGroupPropertyName];
            [self.navigationItem setTitle:sGroupPropertyName];
        });
    }
}
#pragma mark -done
- (void)cancelAction:(UIBarButtonItem *) barButtonItem
{
    SSLImageCropperViewController * sslImageCropperViewController=(SSLImageCropperViewController *) self.navigationController;
    [sslImageCropperViewController cancelImageCropper];
}

#pragma mark -表格数据源及代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_columns <= 0)
    {
        //Sometimes called before we know how many columns we have
        _columns =kELCAssetItemCount;
    }
    NSInteger numRows = ceil([self.sslAssets count] / (float)_columns);
    return numRows;
}

- (NSArray *)assetsForIndexPath:(NSIndexPath *)path
{
    long index = path.row * _columns;
    long length = MIN(_columns, [self.sslAssets count] - index);
    return [self.sslAssets subarrayWithRange:NSMakeRange(index, length)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"Cell";
        
    SSLAssetCell *cell = (SSLAssetCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil)
    {
        cell = [[SSLAssetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.delegate=self;
    }
    
    [cell setAssets:[self assetsForIndexPath:indexPath]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kSSLAssetCellHeight;
}


-(void) sslAssetCell:(SSLAssetCell *)sslAssetCell didSelectAtIndex:(NSInteger)index
{
    
    SSLAsset * sslasset = [sslAssetCell.assets objectAtIndex:index];
    
    ALAsset *asset = sslasset.asset;
    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
    CGImageRef  imgRef = [assetRep fullResolutionImage];
    UIImageOrientation   orientation =(UIImageOrientation)[assetRep orientation];
    UIImage *img =[UIImage imageWithCGImage:imgRef scale:1.0f orientation:orientation];
    
    // 裁剪
    VPImageCropperViewController *vpImageCropperViewController  = [[VPImageCropperViewController alloc] initWithImage:img cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
    vpImageCropperViewController.delegate = self;
    [self.navigationController pushViewController:vpImageCropperViewController animated:YES];
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage
{
    SSLImageCropperViewController * sslImageCropperViewController=(SSLImageCropperViewController *) self.navigationController;
    sslImageCropperViewController.croppedImage=editedImage;
    [sslImageCropperViewController  finishImageCropper];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
