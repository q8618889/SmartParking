//
//  SurrpundView.h
//  SmartParking
//
//  Created by MAXMFJ on 15/12/18.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyScrollView.h"
@interface SurrpundView : UIView
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UIButton *eating;
@property (strong, nonatomic) IBOutlet UIButton *come;
@property (strong, nonatomic) IBOutlet UIButton *mrButton;
@property (strong, nonatomic) IBOutlet UIButton *market;
@property (strong, nonatomic) IBOutlet UIButton *spot;
@property (strong, nonatomic) IBOutlet UIButton *hotel;
@property (strong, nonatomic) IBOutlet UIButton *bank;
@property (strong, nonatomic) IBOutlet UIButton *supermarket;
@property (strong, nonatomic) IBOutlet MyScrollView *myScrollView;

@end
