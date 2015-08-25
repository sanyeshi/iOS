//
//  Asset.h
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@class SSLAsset;

@interface SSLAsset : NSObject

@property (nonatomic, strong) ALAsset  * asset;
@property (nonatomic,assign)  NSUInteger index;

- (id)initWithAsset:(ALAsset *)asset;
@end