//
//  MyNewWorking.m
//  SmartParking
//
//  Created by MAXMFJ on 15/12/8.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "MyNewWorking.h"
#import "MyTool.h"
#import "NetWorking.h"
@implementation MyNewWorking
+(void)registerUser;
{
    
    NSMutableArray * dataArray = [NSMutableArray array];

    [NetWorking addNetWorking:[MyTool dictionaryWithdataArray:@[@"CNM",@"15239870768",@"8618889a"] Array:@[@"userName",@"number",@"passwd"]] url:[NSString stringWithFormat:@"%@/park/insert/user",WEB_SERVER_IP] block:^(NSMutableDictionary *dictionary, NSString *error) {
        NSLog(@"%@",dictionary);
        
        
    }];


}
+(void)getParkingMessageWithLongitude:(NSString *)longitude latitude:(NSString *)latitude radius:(NSString *)radius block:(DATAARRAY)block
{
    NSMutableArray * dataArray = [NSMutableArray array];

    [NetWorking addNetWorking:[MyTool dictionaryWithdataArray:@[longitude,latitude,radius] Array:@[@"longitude",@"latitude",@"radius"]] url:[NSString stringWithFormat:@"%@/park/getNearParks",WEB_SERVER_IP] block:^(NSMutableDictionary *dictionary, NSString *error) {
        
        AnnPoinBaseClass * bc = [AnnPoinBaseClass modelObjectWithDictionary:dictionary];
        [dataArray addObject:bc];
        block(dataArray,error);
    }];
}
+(void)searchParkingMessageWithLongitude:(NSString *)longitude latitude:(NSString *)latitude  portLeftCount:(NSString *)portLeftCount distance:(NSString *)distance parkingName:(NSString *)parkingName block:(DATAARRAY)block;
{

    
    NSMutableArray  * dataArray = [NSMutableArray array];
    [NetWorking addNetWorking:[MyTool dictionaryWithdataArray:@[longitude,latitude,distance,portLeftCount,parkingName] Array:@[@"userLocationlongitude",@"userLocationlatitude",@"distance",@"portLeftCount",@"parkingName",]] url:[NSString stringWithFormat:@"%@/park/search/parking",WEB_SERVER_IP] block:^(NSMutableDictionary *dictionary, NSString *error) {
        AnnPoinBaseClass * bc = [AnnPoinBaseClass modelObjectWithDictionary:dictionary];
        [dataArray addObject:bc];
        NSLog(@"%@",dictionary);
        block(dataArray,error);
    }];
}
@end
