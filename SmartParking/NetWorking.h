//
//  NetWorking.h
//  JiangDuStateTax
//
//  Created by MAXMFJ on 15/11/11.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorking : NSObject
typedef void(^DATAARRAY)(NSMutableArray  * array,NSString       * error);
typedef void(^DATADICT)(NSMutableDictionary  * dictionary,NSString       * error);

+(void)addNetWorking:(NSMutableDictionary *)dataDictionary url:(NSString *)url block:(DATADICT)block;//post 请求
+(void)addNetWorkingAddImage:(NSMutableDictionary *)dataDictionary imageFile:(UIImage *)image url:(NSString *)url block:(DATADICT)block;//有图片的Posth
+ (void)cancelAllOperation;//请求停止
@end
