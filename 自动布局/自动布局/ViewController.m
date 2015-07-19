//
//  ViewController.m
//  自动布局
//
//  Created by 孙硕磊 on 7/18/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"


@interface ViewController ()
@property (nonatomic, strong) UILabel   *textInfoLabel;
@property (nonatomic, strong) UIView    *backgroundView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    self.backgroundView = [[UIView alloc] init];
    [self.backgroundView setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.backgroundView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.backgroundView];
    
    self.textInfoLabel = [[UILabel alloc] init];
    [self.textInfoLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.textInfoLabel.backgroundColor = [UIColor redColor];
    self.textInfoLabel.numberOfLines = 0;
    self.textInfoLabel.font = [UIFont systemFontOfSize:15];
    self.textInfoLabel.text = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
   [self.view addSubview:self.textInfoLabel];
    
    NSDictionary *views = @{@"backgroundView":self.backgroundView, @"textInfoLabel":self.textInfoLabel};
    NSDictionary *metrics = @{@"LeftStep":@20, @"TopStep":@20, @"Width":@200, @"Height":@"100", @"VStep":@20, @"HStep":@20};
    NSString *vLayoutString = @"V:|-TopStep-[backgroundView(==Width)]-VStep-[textInfoLabel(>=20)]";
    NSArray *vLayoutArray = [NSLayoutConstraint constraintsWithVisualFormat:vLayoutString options:0 metrics:metrics views:views];
    
    NSString *hLayoutstring = @"H:|-LeftStep-[backgroundView(==Height)]-HStep-[textInfoLabel(==100)]";
    NSArray *hLayoutArray = [NSLayoutConstraint constraintsWithVisualFormat:hLayoutstring options:0 metrics:metrics views:views];
    
    [self.view addConstraints:vLayoutArray];
    [self.view addConstraints:hLayoutArray];
    
     */
    
}

@end
