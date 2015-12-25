//
//  InfoMessageViewController.h
//  SmartParking
//
//  Created by MAXMFJ on 15/12/22.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "MainViewController.h"
#import "CWStarRateView.h"

@interface InfoMessageViewController : MainViewController
@property (nonatomic,copy)NSString * uid;
@property (nonatomic,assign) double  userlatitude, userlongitude;

@property (nonatomic,copy)NSString * poiTopic,*poiPhone,*poiNumber,*poiAddress;

@property (nonatomic,assign) double  poilatitude, poilongitude;
@property (nonatomic,strong)CWStarRateView * starRateView;

@end
