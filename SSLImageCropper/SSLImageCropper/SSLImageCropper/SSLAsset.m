//
//  Asset.m
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import "SSLAsset.h"
#import "ELCAssetTablePicker.h"

@implementation SSLAsset

- (id)initWithAsset:(ALAsset*)asset
{
	self = [super init];
	if (self)
    {
		self.asset = asset;
    }
	return self;	
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"ELCAsset index:%ld",self.index];
}

@end

