//
//  MapViewController.h
//  SmartParking
//
//  Created by MAXMFJ on 15/12/2.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
@protocol mapZBMessageDelegate <NSObject>
@optional
-(void)getloctionWithlatitude:(NSString *)latitude longitude:(NSString *)longitude;

@end
@interface MapViewController : MainViewController<BMKMapViewDelegate,BMKPoiSearchDelegate>{
     BMKMapView* _mapView;
    
}
@property (nonatomic,assign)id<mapZBMessageDelegate> delegate;
//+ (MapViewController *)sharedManager;
@end
