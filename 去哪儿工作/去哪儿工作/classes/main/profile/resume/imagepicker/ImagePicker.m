//
//  ImagePicker.m
//  parttime
//
//  Created by 孙硕磊 on 5/18/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ImagePicker.h"
#import "ImagePickerCell.h"
#import "UIImageView+WebCache.h"


@interface ImagePicker ()<UICollectionViewDataSource,UICollectionViewDelegate,ImagePickCellDelegate>
{
    UICollectionView  * _collectionView;
    NSMutableSet      * _selectedSet;
}
@end

static NSString * const reuseItemIdentifier = @"Cell";

@implementation ImagePicker

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"选择图片";
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    
     self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(done:)];
    //初始化数据
    _selectedSet=[NSMutableSet set];
    [self loadCollectionView];
    
}

#pragma mark -collectionView
-(void) loadCollectionView
{
    //布局
    UICollectionViewFlowLayout * layout=[[UICollectionViewFlowLayout alloc] init];
    layout.itemSize=CGSizeMake(kImagePickerCellWidth, kImagePickerCellHeight);
    layout.sectionInset=UIEdgeInsetsMake(kMargin,kMargin,kMargin,kMargin);
    layout.minimumLineSpacing=kMargin;
    layout.minimumInteritemSpacing=kMargin;
    //注册类
    _collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    [_collectionView registerClass:[ImagePickerCell class] forCellWithReuseIdentifier:reuseItemIdentifier];
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    [self.view addSubview:_collectionView];
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageUrlStrs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ImagePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseItemIdentifier forIndexPath:indexPath];
    cell.indexPath=indexPath;
    cell.delegate=self;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrlStrs[indexPath.row]] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    return cell;
}


-(void) imagePickerCell:(ImagePickerCell *)imagePickerCell didSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber * number=[NSNumber numberWithInteger:indexPath.row];
    if (imagePickerCell.isSelected)
    {
        if (![_selectedSet containsObject:number])
        {
            [_selectedSet addObject:number];
        }
    }
    else
    {
        if ([_selectedSet containsObject:number])
        {
            [_selectedSet removeObject:number];
        }
    }
}
#pragma mark -UICollectionViewDelegate

-(void) done:(UIBarButtonItem *) barButtonItem
{
    if (_delegate)
    {
        if ([_delegate conformsToProtocol:@protocol(ImagePickerDelegate)])
        {
            [_delegate imagePicker:self didFinishPickingWithSelectedIndexs:[_selectedSet copy]];
        }
    }
}

-(void) cancel:(UIBarButtonItem *) barButtonItem
{
    if (_delegate)
    {
        if ([_delegate conformsToProtocol:@protocol(ImagePickerDelegate)])
        {
            [_delegate imagePickerDidCancel];
        }
    }
}

@end
