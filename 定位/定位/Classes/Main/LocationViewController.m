//
//  ViewController.m
//  定位
//
//  Created by 孙硕磊 on 7/19/15.
//  Copyright (c) 2015 dhu.cst. All rights reserved.
//

#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationViewController ()<CLLocationManagerDelegate>
{
    CLLocationManager * _locationManager;
    UITextView  * _textView;
}
@end

@implementation LocationViewController


/*
   在iOS中通过Core Location框架进行定位操作，包含了定位、地理编码、反编码功能
   iOS 8 还提供了更加人性化的定位服务选项。App 的定位服务不再仅仅是关闭或打开.
   现在，定位服务的启用提供了三个选项，「永不」「使用应用程序期间」和「始终」。
   同时，考虑到能耗问题，如果一款 App 要求始终能在后台开启定位服务，iOS 8 不仅会在首次打开 App 时主动向你询问，
   还会在日常使用中弹窗提醒你该 App 一直在后台使用定位服务，并询问你是否继续允许。
   在iOS7及以前的版本，如果在应用程序中使用定位服务只要在程序中调用startUpdatingLocation方法应用就会询问用户是否允许此应用是否允许使用定位服务，同时在提示过程中可以通过在info.plist中配置通过配置Privacy - Location Usage Description告诉用户使用的目的，同时这个配置是可选的。
 但是在iOS8中配置配置项发生了变化，可以通过配置NSLocationAlwaysUsageDescription或者NSLocationWhenInUseUsageDescription来告诉用户使用定位服务的目的，并且注意这个配置是必须的，如果不进行配置则默认情况下应用无法使用定位服务，打开应用不会给出打开定位服务的提示，除非安装后自己设置此应用的定位服务。
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _textView=[[UITextView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_textView];
    //定位管理器
    _locationManager=[[CLLocationManager alloc] init];
    //是否启动定位服务，通常如果没有启用定位服务可以提示用户打开定位服务
    if (![CLLocationManager locationServicesEnabled])
    {
        NSLog(@"定位服务没有开启");
        return;
    }
    
    //如果用户没有授权，则请求用户授权.若想使用定位服务，必须经过用户授权
    if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined)
    {
        //requestWhenInUseAuthorization请求获得应用的定位服务授权，主要使用此方法前需要在info.plist中配置NSLocationWhenInUsageDescription
        [_locationManager requestWhenInUseAuthorization];
    }
    else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        //NSLog(@"授权完成");
        //设置定位代理
        _locationManager.delegate=self;
        //设置定位精度
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //distanceFilter，位置信息更新最小距离，只有移动距离大于这个距离才更新位置信息，默认为kCLDistanceFilterNone：不进行距离限制
        //定位频率，每隔多少米定位一次
        _locationManager.distanceFilter=10.0f;
        //启动跟踪定位，开始定位后将按照用户设置的更新频率执行
        [_locationManager startUpdatingLocation];
    }
    
    //[self getCoordinateWithAddress:@"上海松江区"];
    
}

#pragma mark -定位管理器代理

//每次位置发生变化，就会执行
-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // NSLog(@"更细位置");
    //取出第一个位置
    CLLocation * location=[locations firstObject];
    //位置坐标
    CLLocationCoordinate2D coordinate=location.coordinate;
   // NSLog(@"经度:%f,纬度:%f,海拔:%f,航向:%f,行走速度:%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    [self getAddressWithLongitude:coordinate.longitude latitude:coordinate.latitude];
    //如果不需要实时定位，使用完，立即关闭定位服务
    [_locationManager stopUpdatingLocation];
    
}

#pragma mark -如何自定义大头针视图


#pragma mark -地理编码和反编码

/*
   GeoCoder
   地理编码:根据给定的地名确定经纬度；
   逆地理编码：可以根据经纬度确定地址信息，如城市、街道、门牌等
 */

-(void) getCoordinateWithAddress:(NSString *) address
{
    //地理编码
    CLGeocoder * geocoder=[[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error)
    {
        if (error)
        {
            NSLog(@"error:%@",error);
        }
        else
        {
           //取第一地表，地标中存储了详细的地址信息，一个地名可能搜索出多个地址
            CLPlacemark * placemark=[placemarks firstObject];
            CLLocation * location=placemark.location;    //位置
            CLRegion   * region=placemark.region;        //区域
            NSDictionary * addressDict=placemark.addressDictionary; //详细地址信息,包含地名，街道，城市等
            NSLog(@"位置:%@,区域:%@,详细信息:%@",location,region,addressDict);
        }
    }];
}


-(void) getAddressWithLongitude:(CLLocationDegrees) longitude latitude:(CLLocationDegrees)latitude
{
    //地理反编码
    CLLocation * location=[[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    CLGeocoder * geocoder=[[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
    {
        if (error)
        {
            NSLog(@"error:%@",error);
        }
        else
        {
            CLPlacemark * placemark=[placemarks firstObject];
            //NSLog(@"详细信息:%@",placemark.addressDictionary);
            _textView.text=placemark.addressDictionary.description;
        }
    }];
    
}

@end






























