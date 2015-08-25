//
//  PunchcardCell.h
//  parttime
//
//  Created by 孙硕磊 on 4/5/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCardCellHeight 150

@class CardCell;
@class Card;

@protocol CardCellDelegate <NSObject>
-(void) cardCell:(CardCell *) cardCell didPunchCardAtIndex:(NSInteger) index;
@end

@interface CardCell : UITableViewCell

@property(nonatomic,assign) id<CardCellDelegate> delegate;
@property(nonatomic,assign) NSInteger     index;
@property(nonatomic,strong) UIImageView * iconImageView;
@property(nonatomic,strong) UILabel     * contactNameLabel;
@property(nonatomic,strong) UILabel     * contactCellphoneLabel;
@property(nonatomic,strong) UILabel     * workDateLabel;
@property(nonatomic,strong) UILabel     * workTypeLabel;
@property(nonatomic,strong) UILabel     * workTitleLabel;
@property(nonatomic,strong) UIButton    * punchcardButton;

@property(nonatomic,strong) Card     *card;
@end
