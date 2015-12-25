//
//  LoginViewController.h
//  JiangDuStateTax
//
//  Created by MAXMFJ on 15/11/2.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *automaticlogin;
@property (weak, nonatomic) IBOutlet UIButton *rememberPasswords;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UIView *BgView;


@end
