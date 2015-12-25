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

@end
