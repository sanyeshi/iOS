
//
//  MainViewController.m
//  瀑布流
//
//  Created by 孙硕磊 on 7/21/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "MainViewController.h"
#import "UICollectionViewWaterFlowLayout.h"
#import "Cell.h"

static NSString * ID=@"ID";

@interface MainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView * _collectionView;
}
@end

@implementation MainViewController

-(void) loadView
{
    /*
    UICollectionViewFlowLayout * layout=[[UICollectionViewFlowLayout alloc] init];
    layout.itemSize=CGSizeMake(120,240);
    layout.sectionInset=UIEdgeInsetsMake(20.0f, 0.0f,0.0f, 0.0f);
    layout.minimumLineSpacing=20.0f;
    layout.minimumInteritemSpacing=0.0f;
     */
    UICollectionViewWaterFlowLayout * layout=[[UICollectionViewWaterFlowLayout alloc] init];
    
    _collectionView=[[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    //在指定数据源之前需要注册Cell类
    [_collectionView registerClass:[Cell class] forCellWithReuseIdentifier:ID];
    _collectionView.backgroundColor=[UIColor whiteColor];
    _collectionView.dataSource=self;
    _collectionView.delegate=self;
    self.view=_collectionView;
}


-(void) viewDidLoad
{
    [super viewDidLoad];
    self.title=@"瀑布流";
    
}


-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}


-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (indexPath.section==0)
    {
          cell.backgroundColor=[UIColor redColor];
    }
    else
    {
         cell.backgroundColor=[UIColor blueColor];
    }
  
    return cell;
}



@end
