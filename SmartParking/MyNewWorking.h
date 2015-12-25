//
//  MyNewWorking.h
//  SmartParking
//
//  Created by MAXMFJ on 15/12/8.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorking.h"
@interface MyNewWorking : NSObject
typedef void(^DATAARRAY)(NSMutableArray  * array,NSString       * error);
typedef void(^DATADICT)(NSMutableDictionary  * dictionary,NSString       * error);
/*
 周边停车场获取
 */
+(void)getParkingMessageWithLongitude:(NSString *)longitude latitude:(NSString *)latitude radius:(NSString *)radius block:(DATAARRAY)block;
/*
 索引周边停车场
 */
+(void)searchParkingMessageWithLongitude:(NSString *)longitude latitude:(NSString *)latitude  portLeftCount:(NSString *)portLeftCount distance:(NSString *)distance parkingName:(NSString *)parkingName block:(DATAARRAY)block;;

@end
