//
//  ELCAssetTablePicker.h
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "SSLAsset.h"
#import "SSLAssetCell.h"
#import "SSLAssetPickerFilterDelegate.h"

@interface SSLAssetTablePicker : UITableViewController <SSLAssetCellDelegate>

@property (nonatomic, strong) ALAssetsGroup    * assetGroup;
@property (nonatomic, strong) NSMutableArray   * sslAssets;

// optional, can be used to filter the assets displayed
@property(nonatomic, weak) id<SSLAssetPickerFilterDelegate> assetPickerFilterDelegate;
- (void)preparePhotos;


@end