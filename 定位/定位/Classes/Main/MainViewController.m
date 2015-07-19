
//
//  MainViewController.m
//  定位
//
//  Created by 孙硕磊 on 7/19/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "MainViewController.h"
#import "LocationViewController.h"
#import "MapAnnotation.h"
#import <MapKit/MapKit.h>



@interface MainViewController ()<MKMapViewDelegate>
{
    CLLocationManager * _locationManager;
    MKMapView *_mapView;
}

@end
@implementation MainViewController
-(void) viewDidLoad
{
    [super viewDidLoad];
    self.title=@"地图";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"定位" style:UIBarButtonItemStylePlain target:self action:@selector(location)];
    //控件
    _mapView=[[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_mapView];
    //设置代理
    _mapView.delegate=self;
    
    //请求定位服务，必须先开启定位服务，才能使用地图
    _locationManager=[[CLLocationManager alloc] init];
    if (![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined)
    {
        //请求服务
        [_locationManager requestWhenInUseAuthorization];
    }
    //用户位置追踪（用户位置追踪，用于标记用户的当前位置，此时会自动调用定位服务）
    _mapView.userTrackingMode=MKUserTrackingModeFollow;
    //设置地图类型,标准类型、卫星模式、混合模式(标准类型+卫星模式)
    _mapView.mapType=MKMapTypeStandard;
    //添加大头针
    [self addAnnotation];
    //设置中心点，在iOS8中不需要指定中心点，默认会将当前位置设置成中心点，并自动设置显示范围
}




/*
 在地图应用中，经常会使用地图标注，也就是俗称的“大头针”。只要一个NSObject类实现MKAnnotation协议就可以
 作为一个大头针，通常会重写协议中coordinate、title、subtitle三个属性，然后在应用程序中创建大头针并调用
 addAnnotation:方法即可。
 大头针是数据模型，具体显示的视图为MKAnnotationView，即大头针视图。
 */
-(void) addAnnotation
{
    MapAnnotation * annotation=[[MapAnnotation alloc] init];
    annotation.title=@"SSL";
    annotation.subtitle=@"ssl sub";
    annotation.coordinate=CLLocationCoordinate2DMake(39.95, 116.35);
    annotation.iconName=@"annotation.png";
    [_mapView addAnnotation:annotation];
    
    
    MapAnnotation * annotation1=[[MapAnnotation alloc] init];
    annotation1.title=@"LFF";
    annotation1.subtitle=@"lff sub";
    annotation1.iconName=@"annotation.png";
    annotation1.coordinate=CLLocationCoordinate2DMake(30.95, 116.35);
    [_mapView addAnnotation:annotation1];
    
    //如何计算两个大头针之间的距离,计算两个位置间的距离
    /*
    CLLocation * location=[[CLLocation alloc] initWithLatitude:39.95 longitude:116.35];
    CLLocation * location1=[[CLLocation alloc] initWithLatitude:29.95 longitude:116.35];
    CLLocationDistance distance=[location distanceFromLocation:location1];
     */
    

    
}

#pragma mark -地图控件代理方法
//更新位置，调用频繁
-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //设置地图显示范围(如果不进行区域设置会自动显示区域范围并指定当前用户位置为地图中心点)
    //MKCoordinateSpan span=MKCoordinateSpanMake(0.01, 0.01);
    //MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.location.coordinate, span);
    //[mapView setRegion:region animated:true];
}

/*
  自定义大头针
  在一些应用中，系统默认的大头针样式可能无法满足实际的需求，此时就需要修改大头针视图的默认样式。
  viewForAnnotation方法可以返回一个大头针视图，只要实现该方法并在这个方法中定义一个大头针视图MKAnnotationView对象
  并设置相关属性就可以改变默认大头针的样式。
  需要注意的是:
  1>每当有大头针显示到系统可视界面中时就会调用此方法返回一个大头针视图放到界面中，同时用户当前位置（地图中蓝色的位置点）也是一个
    大头针，也会调用此方法，因此需要区别对待
  2>此方法调用频繁，开发过程中需要重复利用大头针视图
  3>自定义大头针默认情况下，不允许交互，如果允许交互需要设置canShowCallout=true;
  4>如果返回nil则会使用默认的大头针视图。
 */
-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    //显示大头针时调用，注意方法中的annotation参数是即将显示的大头针,该参数是向mapView添加大头针时的数据模型
    //若返回nil，使用默认的大头针视图
    if([annotation isKindOfClass:[MapAnnotation class]])
    {
        static NSString * ID=@"annotation";
        MKAnnotationView * annotationView=[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
        if (annotationView==nil)
        {
            annotationView=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
            annotationView.canShowCallout=YES;
            //定义详情左侧视图
        }
        //覆盖数据
        annotationView.annotation=annotation;
        annotationView.image=[UIImage imageNamed:((MapAnnotation *) annotation).iconName];
        return annotationView;
    }
    else
    {
        //默热大透针，如用户当前位置
        return nil;
    }
}


-(void) location
{
    LocationViewController * locationViewController=[[LocationViewController alloc] init];
    [self.navigationController pushViewController:locationViewController animated:YES];
}
@end
