//
//  AlbumPickerController.h
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "SSLAssetPickerFilterDelegate.h"

@interface SSLAlbumPickerController : UITableViewController

@property (nonatomic, strong) NSMutableArray   * assetGroups;
@property (nonatomic, strong) NSArray          * mediaTypes;

//optional, can be used to filter the assets displayed
@property (nonatomic, weak) id<SSLAssetPickerFilterDelegate> assetPickerFilterDelegate;

@end

