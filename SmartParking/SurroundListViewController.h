//
//  SurroundListViewController.h
//  SmartParking
//
//  Created by MAXMFJ on 15/12/2.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "ViewController.h"

@interface SurroundListViewController : MainViewController
@property(nonatomic,assign)BOOL    isParking;
-(void)getDelegate;
-(void)getloctionWithlatitude:(NSString *)latitude longitude:(NSString *)longitude;
@end
