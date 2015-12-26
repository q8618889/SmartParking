//
//  ScNewWorking.m
//  SmartParking
//
//  Created by SCMac on 15/12/24.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "ScNewWorking.h"
#import "MyTool.h"
#import "NetWorking.h"

@implementation ScNewWorking


+(void)getLoginWithUserName:(NSString *)userName Password:(NSString *)password block:(DATADICT)block
{
    
    [NetWorking addNetWorking:[MyTool dictionaryWithdataArray:@[userName,password,] Array:@[@"userName",@"password"]] url:[NSString stringWithFormat:@"%@/park/user/login",WEB_SERVER_IP] block:^(NSMutableDictionary *dictionary, NSString *error) {
        
        
        block(dictionary,error);
    }];
}

+(void)getRegistWithUserName:(NSString *)userName Password:(NSString *)password Number:(NSString *)number block:(DATADICT)block
{
    
    [NetWorking addNetWorking:[MyTool dictionaryWithdataArray:@[userName,number,password] Array:@[@"userName",@"number",@"passwd"]] url:[NSString stringWithFormat:@"%@/park/insert/user",WEB_SERVER_IP] block:^(NSMutableDictionary *dictionary, NSString *error) {
        
        block(dictionary,error);
    }];
}
+(void)getuserChangePasswordUserName:(NSString *)userName NewPassword:(NSString *)newPassword Number:(NSString *)number block:(DATADICT)block
{
    
    [NetWorking addNetWorking:[MyTool dictionaryWithdataArray:@[userName,newPassword] Array:@[@"userName",@"newPassword"]] url:[NSString stringWithFormat:@"%@/park/user/changePassword",WEB_SERVER_IP] block:^(NSMutableDictionary *dictionary, NSString *error) {
        
        block(dictionary,error);
    }];
}
+(void)getNewMessageWithPageSize:(NSInteger)page  longitude:(double)longitude latitude:(double)latitude radius:(double)radius block:(DATAARRAY)block;
{
    NSMutableArray * dataArray = [NSMutableArray array];
    NSNumber * numberPage = [NSNumber numberWithInteger:page];
    NSNumber * numberLongitude = [NSNumber numberWithDouble:longitude];
    NSNumber * numberLatitude = [NSNumber numberWithDouble:latitude];
    NSNumber * numberRadius = [NSNumber numberWithDouble:radius];
    NSNumber * pageSize = [NSNumber numberWithDouble:10];
    [NetWorking addNetWorking:[MyTool dictionaryWithdataArray:@[@"dynamicnews",pageSize,numberPage,numberLongitude,numberLatitude,numberRadius]Array:@[@"dynamicNews",@"pageSize",@"offset",@"longitude",@"latitude",@"radius"]] url:[NSString stringWithFormat:@"%@/park/dynamicNews/queryList",WEB_SERVER_IP] block:^(NSMutableDictionary *dictionary, NSString *error) {
        
        
        NewsMessageBaseClass * bc = [[NewsMessageBaseClass alloc]initWithDictionary:dictionary];
        [dataArray addObject:bc];
        NSLog(@"%@",dictionary);
        block(dataArray,error);
    }];
}

+(void)getUpdateUserUserName:(NSString *)userName nickname:(NSString *)nickname block:(DATADICT)block
{
    
    [NetWorking addNetWorking:[MyTool dictionaryWithdataArray:@[userName,nickname] Array:@[@"userName",@"nickname"]] url:[NSString stringWithFormat:@"%@/park/update/user",WEB_SERVER_IP] block:^(NSMutableDictionary *dictionary, NSString *error) {
        
        block(dictionary,error);
    }];
}

+(void)getUploadImage:(NSString *)userName nickname:(NSString *)nickname block:(DATADICT)block
{
    
    [NetWorking addNetWorking:[MyTool dictionaryWithdataArray:@[userName,nickname] Array:@[@"userName",@"nickname"]] url:[NSString stringWithFormat:@"%@/park/upload",WEB_SERVER_IP] block:^(NSMutableDictionary *dictionary, NSString *error) {
        
        block(dictionary,error);
    }];
}
@end
