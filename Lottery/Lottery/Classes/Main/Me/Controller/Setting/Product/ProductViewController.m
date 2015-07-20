//
//  ProductViewController.m
//  Lottery
//
//  Created by 孙硕磊 on 6/26/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductCell.h"
#import "ProductModel.h"


static NSString * const ID=@"CELL";
@interface ProductViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray * _productModels;
}
@end

@implementation ProductViewController

-(void) loadView
{
    UICollectionViewFlowLayout * flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize=CGSizeMake(80, 80);
    flowLayout.minimumInteritemSpacing=0;
    flowLayout.sectionInset=UIEdgeInsetsMake(20, 0, 0, 0);
    
    UICollectionView * collectionView=[[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame collectionViewLayout:flowLayout];
    [collectionView registerClass:[ProductCell class] forCellWithReuseIdentifier:ID];
    collectionView.dataSource=self;
    collectionView.delegate=self;
    collectionView.backgroundColor=[UIColor whiteColor];
    self.view=collectionView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"产品推荐";
    //加载数据
    NSArray * json=LotteryJSON(@"product.json");
    NSMutableArray * mutableArray=[NSMutableArray arrayWithCapacity:json.count];
    for (NSDictionary * dict in json)
    {
       [mutableArray addObject:[ProductModel productModelWithDict:dict]];
    }
    _productModels=[mutableArray copy];
}


-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _productModels.count;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.productModel=_productModels[indexPath.item];
    return cell;
}


@end
