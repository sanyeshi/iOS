//
//  AssetCell.h
//
//  Created by ELC on 2/15/11.
//  Copyright 2011 ELC Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSSLAssetCellHeight 79

@class SSLAssetCell;

@protocol SSLAssetCellDelegate <NSObject>
-(void) sslAssetCell:(SSLAssetCell *) sslAssetCell didSelectAtIndex:(NSInteger) index;
@end

@interface SSLAssetCell : UITableViewCell

@property(nonatomic,assign) id<SSLAssetCellDelegate> delegate;
@property(nonatomic,strong) NSArray *    assets ;

@end
