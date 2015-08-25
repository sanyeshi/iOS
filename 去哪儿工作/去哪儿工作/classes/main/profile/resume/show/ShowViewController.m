//
//  ShowViewController.m
//  parttime
//
//  Created by 孙硕磊 on 4/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ShowViewController.h"
#import "ShowCell.h"
#import "PhotoBowserViewController.h"
#import "ELCImagePicker.h"
#import "UIImageView+WebCache.h"

#import "NavigationController.h"
#import "ImagePicker.h"

#import "MBProgressHUD.h"
#import "EmployeeHttp.h"



@interface ShowViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,ELCImagePickerControllerDelegate,ImagePickerDelegate>
{
    
    UIView  * _moreView;
    UIView  * _coverView;

    UICollectionView  * _collectionView;
    NSMutableArray    * _frames;
    NSMutableArray    * _imageUrlStrs;
    NSArray           * _chosenImages;
    
}
@end

@implementation ShowViewController

static NSString * const reuseItemIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"个人展示";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(more:)];

    //初始化数据
    _imageUrlStrs=[[NSMutableArray alloc] initWithArray:self.resume.imageUrlStrs];
    _frames=[NSMutableArray arrayWithCapacity:_imageUrlStrs.count];
    [self loadCollectionView];
    
}

#pragma mark -collectionView
-(void) loadCollectionView
{
    //布局
    UICollectionViewFlowLayout * layout=[[UICollectionViewFlowLayout alloc] init];
    layout.itemSize=CGSizeMake(kShowCellWidth, kShowCellHeight);
    layout.sectionInset=UIEdgeInsetsMake(kMargin,kMargin,kMargin,kMargin);
    layout.minimumLineSpacing=kMargin;
    layout.minimumInteritemSpacing=kMargin;
    //注册类
    _collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [_collectionView registerClass:[ShowCell class] forCellWithReuseIdentifier:reuseItemIdentifier];
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    [self.view addSubview:_collectionView];
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageUrlStrs.count+_chosenImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    ShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseItemIdentifier forIndexPath:indexPath];
    if (indexPath.row<_imageUrlStrs.count)
    {
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrlStrs[indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    else
    {
        cell.imageView.image=_chosenImages[indexPath.row-_imageUrlStrs.count];
    }
    
    if (_frames.count>indexPath.row)
    {
         [_frames replaceObjectAtIndex:indexPath.row withObject:[NSValue valueWithCGRect:cell.frame]];
    }
    else
    {
        [_frames insertObject:[NSValue valueWithCGRect:cell.frame] atIndex:indexPath.row];
    }
   
    return cell;
}

#pragma mark -UICollectionViewDelegate

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self showPhotos:indexPath];
}

-(void) more:(UIBarButtonItem *) barButtonItem
{
    if (_moreView)
    {
        [self hideMoreView];
    }
    else
    {
        _moreView=[self moreView];
        _moreView.frame=CGRectMake(0, 0, self.view.frame.size.width, 64);
        _coverView=[[UIView alloc] initWithFrame:self.view.bounds];
        _coverView.backgroundColor=[UIColor blackColor];
        _coverView.alpha=0.5;
        UIGestureRecognizer * tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_coverView addGestureRecognizer:tap];
        [self.view addSubview:_coverView];
        
        barButtonItem.enabled=NO;
        [self.navigationController.view insertSubview:_moreView belowSubview:self.navigationController.navigationBar];
        [UIView animateWithDuration:0.3f animations:^
         {
             _moreView.frame=CGRectMake(0, 64, self.view.frame.size.width, 64);
         } completion:^(BOOL finished)
         {
             barButtonItem.enabled=YES;
         }];
    }
}

#pragma mark -更多视图
-(UIView *) moreView
{
    CGFloat width=self.view.frame.size.width;
    CGFloat separatorWidth=1.0f;
    CGFloat btnWidth=(width-separatorWidth)*0.5;
    
    UIView * view=[[UIView alloc] init];
    view.backgroundColor=[UIColor whiteColor];
    
    UIButton * addBtn=[self buttonWithTitle:@"添加" image:nil];
    addBtn.frame=CGRectMake(0, 0, btnWidth, 64);
    [addBtn addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchDown];
    [view addSubview:addBtn];
    
    UIView * separator=[[UIView alloc] init];
    separator.backgroundColor=GlobalSeparatorColor;
    separator.frame=CGRectMake(CGRectGetMaxX(addBtn.frame), 0, separatorWidth, 64);
    [view addSubview:separator];
    
    UIButton * delBtn=[self buttonWithTitle:@"删除" image:nil];
    delBtn.frame=CGRectMake(CGRectGetMaxX(separator.frame), 0, btnWidth, 64);
    [delBtn addTarget:self action:@selector(del:) forControlEvents:UIControlEventTouchDown];
    [view addSubview:delBtn];
    
    return view;
}

-(void) hideMoreView
{
    if (_moreView)
    {
        [UIView animateWithDuration:0.3f animations:^
         {
             _coverView.backgroundColor=[UIColor clearColor];
             _moreView.frame=CGRectMake(0, 0, self.view.frame.size.width, 64);
         }
                         completion:^(BOOL finished)
         {
             [_coverView removeFromSuperview];
             [_moreView removeFromSuperview];
             _coverView=nil;
             _moreView=nil;
         }];
    }
}

-(UIButton *) buttonWithTitle:(NSString *) title image:(UIImage *) image
{
    UIButton * button=[[UIButton alloc] init];
    button.titleLabel.font=[UIFont boldSystemFontOfSize:12.0f];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

-(void) tap:(UITapGestureRecognizer *) tapGestureRecognizer
{
    [self hideMoreView];
}

-(void) add:(UIButton *) button
{
    if (_moreView)
    {
        [_coverView removeFromSuperview];
        [_moreView removeFromSuperview];
        _moreView=nil;
        _coverView=nil;
    }
    [self pickImage];
}

-(void) del:(UIButton *) button
{
    if (_moreView)
    {
        [_coverView removeFromSuperview];
        [_moreView removeFromSuperview];
        _moreView=nil;
        _coverView=nil;
    }
    ImagePicker * imagePicker=[[ImagePicker alloc] init];
    imagePicker.imageUrlStrs=_imageUrlStrs;
    imagePicker.delegate=self;
    
    NavigationController * nav=[[NavigationController alloc] init];
    nav.rootViewController=imagePicker;
    [self presentViewController:nav animated:YES completion:nil];
}


#pragma mark -删除图片
-(void) imagePicker:(ImagePicker *) imagePicker didFinishPickingWithSelectedIndexs:(NSSet *) selectedIndexs
{
    NSMutableArray * array=[NSMutableArray array];
    for (int  i=0; i<_imageUrlStrs.count; i++)
    {
        NSNumber * number=[NSNumber numberWithInteger:i];
        if (![selectedIndexs containsObject:number])
        {
            [array addObject:_imageUrlStrs[i]];
        }
    }
    _imageUrlStrs=array;
    [_collectionView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:^
    {
        [self updateImagesWithImageUrls:_imageUrlStrs];
    }];
    
}
-(void) imagePickerDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -更新图片
-(void) updateImagesWithImageUrls:(NSArray *)imageUrls
{
    //请求数据
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = @"更新中";
    [hud show:YES];
    
    [EmployeeHttp updateEmployeeShowWithImages:[self getImagesString:imageUrls] success:^(BOOL isSuccess)
    {
        [hud removeFromSuperview];
        if (isSuccess)
        {
            self.resume.imageUrlStrs=imageUrls;
        }
    } fail:^
    {
        [hud removeFromSuperview];
    }];
}

-(void) updateImagesWithNewImages:(NSArray * ) images oldImageUrls:(NSArray *) oldImageUrls
{
    //请求数据
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.labelText = @"更新中";
    [hud show:YES];
    
    //首先上传图片
    [Http uploadImagesWithImages:images success:^(NSArray *md5s)
    {
        NSMutableArray * imageUrls=[[NSMutableArray alloc] initWithArray:oldImageUrls];
        for (NSString * md5 in md5s)
        {
            [imageUrls addObject:ImageURL(md5)];
        }
        [EmployeeHttp updateEmployeeShowWithImages:[self getImagesString:imageUrls] success:^(BOOL isSuccess)
         {
             [hud removeFromSuperview];
             if (isSuccess)
             {
                 self.resume.imageUrlStrs=imageUrls;
                 _imageUrlStrs=[NSMutableArray arrayWithArray:imageUrls];
             }
         } fail:^
         {
             [hud removeFromSuperview];
         }];
        
    } fail:^{
        [hud removeFromSuperview];
    }];
}

#pragma mark -获取图片MD5字符串
-(NSString *) getImagesString:(NSArray *) array
{
    NSMutableString * string=[NSMutableString string];
    NSInteger count=array.count;
    for (int i=0; i<count; i++)
    {
        NSString * imageUrl=array[i];
        NSRange  range=[imageUrl rangeOfString:kImageBaseUrl];
        NSInteger index=range.location+range.length+1;
        NSString * md5=[imageUrl substringFromIndex:index];
        [string appendString:md5];
        
        if (i+1!=count)
        {
            [string appendString:@";"];
        }
    }
    return [string copy];
}
-(void) viewWillDisappear:(BOOL)animated
{
    if (_moreView)
    {
        [_coverView removeFromSuperview];
        [_moreView removeFromSuperview];
        _moreView=nil;
        _coverView=nil;
    }
}

#pragma mark - 显示照片浏览器
- (void)showPhotos:(NSIndexPath *)indexPath
{
    PhotoBowserViewController *controller = [[PhotoBowserViewController alloc]init];
    
    // 设置照片数组
    NSUInteger  count=_frames.count;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger i=0; i<count; i++)
    {
        NSValue * value=_frames[i];
        CGRect frame =[value CGRectValue];
        CGRect srcFrame = [_collectionView convertRect:frame toView:self.view];
        PhotoModel *p = [PhotoModel photoWithURL:nil index:i srcFrame:srcFrame];
        if (i<_imageUrlStrs.count)
        {
             p.imageUrl=[NSURL URLWithString:_imageUrlStrs[i]];
        }
        else
        {
            p.image=_chosenImages[i-_imageUrlStrs.count];
        }
        [array addObject:p];
    }
    [controller setPhotoList:array];
    [controller setCurrentIndex:indexPath.row];
    [controller show];
}

#pragma mark - 选取本地图片
- (void) pickImage
{
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    
    elcPicker.maximumImagesCount = 100;    //Set the maximum number of images to select to 100
    elcPicker.returnsOriginalImage = YES;  //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES;          //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = YES;               //For multiple image selection, display and return order of selected images
    elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}



#pragma mark -添加图片
#pragma mark -ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
    for (NSDictionary *dict in info)
    {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto)
        {
            if ([dict objectForKey:UIImagePickerControllerOriginalImage])
            {
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                [images addObject:image];
            }
            else
            {
                Log(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        }
        else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo)
        {
            if ([dict objectForKey:UIImagePickerControllerOriginalImage])
            {
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                [images addObject:image];
            }
            else
            {
                Log(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        }
        else
        {
            Log(@"Uknown asset type");
        }
    }
    _chosenImages = images;
    [_frames removeAllObjects];
    [_collectionView reloadData];
    if (_chosenImages.count>0)
    {
      [self updateImagesWithNewImages:_chosenImages oldImageUrls:_imageUrlStrs];
    }
}


- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
