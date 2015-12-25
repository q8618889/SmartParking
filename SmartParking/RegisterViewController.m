//
//  RegisterViewController.m
//  SmartParking
//
//  Created by SCMac on 15/12/23.
//  Copyright © 2015年 MAX-MENGFANJIE. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor colorWithRed:232.0f / 255.0f green:234.0f / 255.0f blue:235.0f / 255.0f alpha:1];
    [[self.bgView layer]setCornerRadius:5.0];//圆角
    [[self.zhuCe layer]setCornerRadius:4.0f];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)registButton:(id)sender {
    
    if ([_userName.text isEqualToString:@""]||[_passworldTfd.text isEqualToString:@""]||[_telephoneTfd.text isEqualToString:@""]) {
        UIAlertView *aleat = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                       message:@"手机号/密码/用户名  不能为空!"
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:@"取消", nil];
        [aleat show];
    }else {
        
        [ScNewWorking getRegistWithUserName:_userName.text Password:_passworldTfd.text Number:_telephoneTfd.text block:^(NSMutableArray *array, NSString *error) {
            
            
        }];
        
        
    }
    
    
    
}
@end
