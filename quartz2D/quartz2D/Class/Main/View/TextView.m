//
//  TextView.m
//  quartz2D
//
//  Created by 孙硕磊 on 7/2/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "TextView.h"

@implementation TextView

- (void)drawRect:(CGRect)rect
{
    //[self drawEnglish];
    [self drawChinese];
}

-(void) drawEnglish
{
    NSString * text=@"Hello World Hello World Marker Felt Marker Felt Marker Felt Marker Felt";
   // NSLog(@"%@",[UIFont familyNames]);
    UIFont * font=[UIFont fontWithName:@"Marker Felt" size:18.0f];
    //[text drawAtPoint:CGPointMake(0, 0) withAttributes:@{NSFontAttributeName:font}];
    [text drawInRect:CGRectMake(0, 0, 320, 200) withAttributes:@{NSFontAttributeName:font}];
}

-(void) drawChinese
{
    NSString * text=@"相见时难别亦难";
    // NSLog(@"%@",[UIFont familyNames]);
    UIFont * font=[UIFont fontWithName:@"Marker Felt" size:18.0f];
    //[text drawAtPoint:CGPointMake(0, 0) withAttributes:@{NSFontAttributeName:font}];
    [text drawInRect:CGRectMake(0, 0, 20, 400) withAttributes:@{NSFontAttributeName:font}];

}

@end
