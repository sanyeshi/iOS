//
//  SettingCell.m
//  Lottery
//
//  Created by 孙硕磊 on 6/25/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "SettingCell.h"
#import "SettingItem.h"
#import "SettingArrowItem.h"
#import "SettingSwitchItem.h"
#import "SettingLabelItem.h"

#define kCellMargin 10

@interface SettingCell ()
{
    UIImageView * _arrow;
    UISwitch    * _switch;
    UILabel     * _label;
    UIView      * _separator;  //分割线
}
@end

@implementation SettingCell

+ (instancetype)settingCellWithTableView:(UITableView *)tableView
{
    static NSString * identifer=@"SettingCell";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell==nil)
    {
        cell=[[SettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
    }
    return cell;
}

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //设置背景属性
        [self setupBackground];
        //设置子控件属性
        [self setupSubViews];
        //添加分割线
        [self setupSeparator];
    }
    return self;
}

-(void) setupBackground
{
    //默认
    UIView * backgroundView=[[UIView alloc] init];
    backgroundView.backgroundColor=[UIColor whiteColor];
    self.backgroundView=backgroundView;
    
    //选中背景
    UIView * selectedBackgroundView=[[UIView alloc] init];
    selectedBackgroundView.backgroundColor=LotteryColor(240, 240, 240);
    self.selectedBackgroundView=selectedBackgroundView;
}

-(void) setupSubViews
{
    self.textLabel.backgroundColor=[UIColor clearColor];
    self.textLabel.font=[UIFont systemFontOfSize:14.0f];
    self.detailTextLabel.backgroundColor=[UIColor clearColor];
    self.detailTextLabel.font=[UIFont systemFontOfSize:12.0f];
}

#warning 自定义分割线
-(void) setupSeparator
{
    _separator=[[UIView alloc] init];
    _separator.backgroundColor=LotteryColor(226, 226, 226);
   //[self.contentView addSubview:_separator];
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    //设置分割线位置
  //  _separator.frame=CGRectMake(0, 0, self.frame.size.width, 0.5);
    
    if (iOS7) return;
    #warning 适配iOS6
    /*
       保持iOS6和iOS7表格样式一致
       在iOS6中，contentView需要拉伸，故需要将cell拉伸
     */
    CGFloat deltaW=2*kCellMargin;
    
    CGRect cellFrame=self.frame;
    cellFrame.origin.x=-kCellMargin;
    cellFrame.size.width=[UIScreen mainScreen].bounds.size.width+deltaW;
    self.frame=cellFrame;
    
    /*
       accessoryView的父类为self，并不是contentView
     */
    CGRect accessoryViewFrame=self.accessoryView.frame;
    accessoryViewFrame.origin.x=cellFrame.size.width-accessoryViewFrame.size.width-deltaW;
    self.accessoryView.frame=accessoryViewFrame;
    
}

-(void) setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath=indexPath;
    _separator.hidden=indexPath.row==0;
}

- (void)setSettingItem:(SettingItem *)settingItem
{
    _settingItem=settingItem;
    if (settingItem.iconName)
    {
      self.imageView.image=[UIImage imageNamed:settingItem.iconName];
    }
    if (settingItem.title)
    {
      self.textLabel.text=settingItem.title;
    }
    if (settingItem.subTitle)
    {
      self.detailTextLabel.text=settingItem.subTitle;
    }
    if ([settingItem isKindOfClass:[SettingArrowItem class]])
    {
        if (_arrow==nil)
        {
            _arrow=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
        }
        self.accessoryView=_arrow;
        self.selectionStyle=UITableViewCellSelectionStyleGray;
    }
    else if (([settingItem isKindOfClass:[SettingSwitchItem class]]))
    {
        if (_switch==nil)
        {
            _switch=[[UISwitch alloc] init];
            [_switch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
        }
         SettingSwitchItem * switchItem=(SettingSwitchItem *) settingItem;
         _switch.on=switchItem.on;
        self.accessoryView=_switch;
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    else if (([settingItem isKindOfClass:[SettingLabelItem class]]))
    {
        if (_label==nil)
        {
            _label=[[UILabel alloc] init];
            _label.bounds=CGRectMake(0, 0, 100, self.frame.size.height);
            _label.font=[UIFont systemFontOfSize:12.0f];
            _label.backgroundColor=[UIColor clearColor];
            _label.textColor=LotteryColor(173,69,14);
            _label.textAlignment=NSTextAlignmentRight;
         }
         SettingLabelItem * labelItem=(SettingLabelItem *) settingItem;
         _label.text=labelItem.text;
        self.accessoryView=_label;
        self.selectionStyle=UITableViewCellSelectionStyleGray;
    }
    else
    {
        self.accessoryView=nil;
        self.selectionStyle=UITableViewCellSelectionStyleGray;
    }
}


-(void) switchChange:(UISwitch *) sender
{
     SettingSwitchItem * switchItem=(SettingSwitchItem *)_settingItem;
     switchItem.on=sender.on;
}
@end
