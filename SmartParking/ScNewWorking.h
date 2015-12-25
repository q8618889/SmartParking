//
//  ScNewWorking.h
//  SmartParking
//
//  Created by SCMac on 15/12/24.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScNewWorking : NSObject

typedef void(^DATAARRAY)(NSMutableArray  * array,NSString       * error);
typedef void(^DATADICT)(NSMutableDictionary  * dictionary,NSString       * error);

//用户登录接口
+(void)getLoginWithUserName:(NSString *)userName Password:(NSString *)password block:(DATAARRAY)block;

//用户注册接口
+(void)getRegistWithUserName:(NSString *)userName Password:(NSString *)password Number:(NSString *)number block:(DATAARRAY)block;

//用户修改密码就扣
+(void)getuserChangePasswordUserName:(NSString *)userName NewPassword:(NSString *)newPassword Number:(NSString *)number block:(DATAARRAY)block;

@end
