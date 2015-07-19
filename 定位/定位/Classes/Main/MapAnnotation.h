//
//  MapAnnotation.h
//  定位
//
//  Created by 孙硕磊 on 7/19/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject<MKAnnotation>

@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy)   NSString *title;
@property (nonatomic,copy)   NSString *subtitle;
@property(nonatomic,copy)    NSString *iconName ;

@end
