//
//  InfoHeaderView.m
//  parttime
//
//  Created by 孙硕磊 on 3/28/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//


#import "NewsHeaderView.h"


@implementation NewsHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.dateLabel=[[UILabel alloc] init];
        _dateLabel.textAlignment=NSTextAlignmentCenter;
        _dateLabel.textColor=GlobalBackgroundTextColor;
        _dateLabel.font=GlobalFont;
        [self addSubview:_dateLabel];
    }
    return self;
}
- (void)layoutSubviews
{
    _dateLabel.frame=CGRectMake(0, 10, self.frame.size.width, self.frame.size.height-10);
}

@end
