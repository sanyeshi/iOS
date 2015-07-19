//
//  ALViewController.m
//  自动布局
//
//  Created by 孙硕磊 on 7/18/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "ALViewController.h"
#import "NSLayoutConstraint+Mutil.h"

@interface ALViewController ()

@property(nonatomic,weak) UIView * redView;
@property(nonatomic,weak) UIView * blueView;
@property(nonatomic,weak) UIView * greenView;


@end

@implementation ALViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.translatesAutoresizingMaskIntoConstraints=NO;
    
    //UIView
    UIView * redView=[[UIView alloc] init];
    redView.backgroundColor=[UIColor redColor];
    redView.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addSubview:redView];
    self.redView=redView;
    
    
    UIView * blueView=[[UIView alloc] init];
    blueView.backgroundColor=[UIColor blueColor];
    blueView.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addSubview:blueView];
    self.blueView=blueView;
    
    
    UIView * greenView=[[UIView alloc] init];
    greenView.backgroundColor=[UIColor greenColor];
    greenView.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addSubview:greenView];
    self.greenView=greenView;
    
    
    /*
    NSLayoutConstraint * leftLCRedView=[NSLayoutConstraint constraintWithItem:_redView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint * topLCRedView=[NSLayoutConstraint constraintWithItem:_redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f];
    
     NSLayoutConstraint * widthRedView=[NSLayoutConstraint constraintWithItem:_redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.5f constant:0.0f];
    
    
    NSLayoutConstraint * rightLCBlueView=[NSLayoutConstraint constraintWithItem:_blueView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f];
    
    NSLayoutConstraint * topLCBlueView=[NSLayoutConstraint constraintWithItem:_blueView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f];


     NSLayoutConstraint * widthBlueView=[NSLayoutConstraint constraintWithItem:_blueView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.5f constant:0.0f];
     */

     //[self.view addConstraints:@[leftLCRedView,topLCRedView]];
     //[self.view addConstraints:@[leftLCRedView,topLCRedView,widthRedView,rightLCBlueView,topLCBlueView,widthBlueView]];
    
    /*
        规则:
        1>方向(H:或V:)
        2>视图采用[]表示，[]内加上控件名，如[button]表示button控件；在控件名上可以附加(),
          ()里面可以写上关系和数值(在H方向上表示宽度，而在V放上表示高度)，如[button(==300)],表示button的宽度为300，
          对于>=,<=关系可以组合使用,如[button(>=200,<=300)],表示button的宽度结余200~300之间；
          此外，数值也可为其他控件的值，如[button(==button1)],表示button和button1的宽度一致；
        3>-表示视图见的间距，若视图之间没有间距，则可省略。
           视图之间的关系为[视图]-数值-[视图]来表示，在H方向上表示两个视图之间的水平间距，而父视图采用|来表示，如
          3.1>视图1与父视图左边间距为20，则可表示为|-20-[view1];
          3.2>视图1与父视图左边和右边间距都为20，则表示为|-20-[view1]-20-|;
          3.3>若视图之间没有间距，则两个视图可以不用-来连接，如|[view1]表示视图1和父视图左边对齐，
              而[view1][view2]则表视图view1和视图view2水平方向上没有间距，类似与流布局；
              也就视图与父视图之间为对齐关系，而子视图之间为水平布局关系；
         3.4>
     */
    
    NSDictionary * views=@{@"redView":self.redView,@"blueView":self.blueView,@"greenView":self.greenView};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormats:@[@"H:|-20-[redView(==blueView)]-20-[blueView]-20-|",
                                                                                 @"V:|-20-[redView(==150)]",
                                                                                 @"V:|-20-[blueView(==redView)]",
                                                                                 @"H:|-20-[greenView]-20-|",
                                                                                 @"V:[redView]-20-[greenView]-20-|"] views:views]];
    

}

@end
