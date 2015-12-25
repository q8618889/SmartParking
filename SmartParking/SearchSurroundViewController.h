//
//  SearchSurroundViewController.h
//  SmartParking
//
//  Created by MAXMFJ on 15/12/21.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchSurroundViewController : MainViewController
//接收传进来的信息
@property (nonatomic,assign)double  userlatitude;
@property (nonatomic,assign)double  userlongitude;
@property (nonatomic,copy)    NSString *userChange;//标记搜索内容的信息

@end
