//
//  NetWorking.m
//  JiangDuStateTax
//
//  Created by MAXMFJ on 15/11/11.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "NetWorking.h"
#import "AFHTTPSessionManager.h"
static AFHTTPSessionManager *_httpManager;

//http://192.168.1.76:8080/jdgs_intf/user/userLogin.do
@implementation NetWorking
+ (AFHTTPSessionManager *)httpManager
{
    if (!_httpManager)
    {
        _httpManager = [AFHTTPSessionManager manager];
        _httpManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [_httpManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return _httpManager;
}


+(void)addNetWorking:(NSMutableDictionary *)dataDictionary url:(NSString *)url block:(DATADICT)block
{
   

   
 
 //   session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

    //session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];

    [[self httpManager] POST:url parameters:[self dictionaryToJson:dataDictionary] success:^(NSURLSessionDataTask *task, id responseObject) {
        //NSString * responseString = [[NSString alloc] initWithData:responseObject   encoding:NSUTF8StringEncoding];
        NSMutableDictionary*dict= [NSJSONSerialization JSONObjectWithData:responseObject  options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",[self dictionaryToJson:dict]);
        block(dict, @"success");

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        block(nil,@"error");
    }];
}
+(void)addNetWorkingAddImage:(NSMutableDictionary *)dataDictionary imageFile:(UIImage *)image url:(NSString *)url block:(DATADICT)block
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.0);
    NSLog(@"%@",dataDictionary);
     [[self httpManager] POST:url parameters:dataDictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
         if (imageData != nil)
         {
             [formData appendPartWithFileData :imageData name:@"fileUrl" fileName:@"userImage.png" mimeType:@"image/jpg/png"];
         }
     } success:^(NSURLSessionDataTask *task, id responseObject) {
          //NSString * responseString = [[NSString alloc] initWithData:responseObject   encoding:NSUTF8StringEncoding];
         NSMutableDictionary*dict= [NSJSONSerialization JSONObjectWithData:responseObject  options:NSJSONReadingAllowFragments error:nil];

         block(dict,nil);
     } failure:^(NSURLSessionDataTask *task, NSError *error) {
         NSLog(@"%@",error);
         block(nil,@"error");
     }];
}
//+(NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
//    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
//    return responseJSON;
//}
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    NSString * str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    return str;
}
+ (void)cancelAllOperation
{
    [[self httpManager].operationQueue cancelAllOperations];
}
//
//+(NSMutableDictionary *)Base64PasswdWithDict:(NSMutableDictionary *)parameters
//{
//    NSMutableDictionary *  dict = [NSMutableDictionary dictionary];
//    NSString * str = [self dictionaryToJson:parameters];
//    NSString * dataStr = [NSData  Encrypt:str];
//    [dict setObject:dataStr forKey:@"s"];
//    [dict setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"versionCode"];
//    [dict setObject:@"ios" forKey:@"deviceType"];
//    
//    return dict;
//}
//+(NSMutableDictionary *)Base64ImagePasswdWithDict:(NSMutableDictionary *)parameters
//                                            image:(UIImage *)image;
//{
//    NSMutableDictionary *  dict = [NSMutableDictionary dictionary];
//    NSString * str = [self dictionaryToJson:parameters];
//    NSString * dataStr = [NSData  Encrypt:str];
//    [dict setObject:dataStr forKey:@"s"];
//    [dict setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"versionCode"];
//    [dict setObject:@"ios" forKey:@"deviceType"];
//    [dict setObject:[parameters objectForKey:@"userId"] forKey:@"userId"];
//    if(image == nil)
//    {
//        [dict setObject:@"" forKey:@"fileUrl"];
//    }
//    return dict;
//}
//+(NSData *)dataWithJson:(NSString *)str
//{
//    NSString * dataStr = [NSData Decrypt:str];
//    NSData* xmlData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
//    return xmlData;
//}
@end
