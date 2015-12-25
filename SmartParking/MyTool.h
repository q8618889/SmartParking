//
//  MyTool.h
//  OrderDish
//
//  Created by 孙 化育 on 14-7-30.
//  Copyright (c) 2014年 孙 化育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTool : NSObject

+ (void)gotoViewController:(UIViewController *)vc;

+ (void)flipView:(UIView *)view;
+ (UIViewController *)viewControllerWithSubView:(UIView *)view;//获取父视图vc

+ (void)RefreshingWithTableView:(UITableView *)myTableView target:(UIView *)tarhetView;//添加刷新
+(NSMutableDictionary *)dictionaryWithdataArray:(NSArray *)dataArray Array:(NSArray *)array;//添加请求头的参数


//获取文件路径
+ (NSString *)getFilePathWithDirectoryName:(NSString *)directoryName fileName:(NSString *)fileName;
@end
